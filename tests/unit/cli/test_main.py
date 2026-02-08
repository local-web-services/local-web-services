"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from ldk.cli.main import (
    _build_gsi,
    _build_key_schema,
    _create_providers,
    _find_node_id,
)
from ldk.config.loader import LdkConfig
from ldk.graph.builder import AppGraph, GraphNode, NodeType, build_graph
from ldk.parser.assembly import (
    AppModel,
    DynamoTable,
    LambdaFunction,
)


class TestBuildKeySchema:
    """Tests for _build_key_schema."""

    def test_hash_only(self):
        raw = [{"attribute_name": "pk", "type": "S", "key_type": "HASH"}]
        ks = _build_key_schema(raw)
        assert ks.partition_key.name == "pk"
        assert ks.partition_key.type == "S"
        assert ks.sort_key is None

    def test_hash_and_range(self):
        raw = [
            {"attribute_name": "pk", "type": "S", "key_type": "HASH"},
            {"attribute_name": "sk", "type": "S", "key_type": "RANGE"},
        ]
        ks = _build_key_schema(raw)
        assert ks.partition_key.name == "pk"
        assert ks.sort_key is not None
        assert ks.sort_key.name == "sk"

    def test_empty_defaults(self):
        ks = _build_key_schema([])
        assert ks.partition_key.name == "pk"
        assert ks.sort_key is None


class TestBuildGsi:
    """Tests for _build_gsi."""

    def test_basic_gsi(self):
        raw = {
            "index_name": "idx1",
            "key_schema": [{"attribute_name": "gsi_pk", "type": "S", "key_type": "HASH"}],
            "projection_type": "KEYS_ONLY",
        }
        gsi = _build_gsi(raw)
        assert gsi.index_name == "idx1"
        assert gsi.key_schema.partition_key.name == "gsi_pk"
        assert gsi.projection_type == "KEYS_ONLY"


class TestFindNodeId:
    """Tests for _find_node_id."""

    def test_direct_match(self):
        graph = AppGraph()
        graph.add_node(GraphNode(id="MyTable", node_type=NodeType.DYNAMODB_TABLE, config={}))
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "MyTable")
        assert result == "MyTable"

    def test_config_match(self):
        graph = AppGraph()
        graph.add_node(
            GraphNode(
                id="TableLogicalId",
                node_type=NodeType.DYNAMODB_TABLE,
                config={"table_name": "Items"},
            )
        )
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "Items")
        assert result == "TableLogicalId"

    def test_fallback_returns_name(self):
        graph = AppGraph()
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "Unknown")
        assert result == "Unknown"


class TestCreateProviders:
    """Tests for _create_providers."""

    def test_creates_dynamo_provider(self, tmp_path):
        app_model = AppModel(
            tables=[
                DynamoTable(
                    name="TestTable",
                    key_schema=[{"attribute_name": "id", "type": "S", "key_type": "HASH"}],
                )
            ],
        )
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, compute_providers = _create_providers(app_model, graph, config, tmp_path)

        assert isinstance(compute_providers, dict)
        # Should have the dynamo table provider + dynamo HTTP provider
        assert "__dynamodb_http__" in providers

    def test_creates_lambda_providers(self, tmp_path):
        app_model = AppModel(
            functions=[
                LambdaFunction(
                    name="MyFunc",
                    handler="index.handler",
                    runtime="nodejs20.x",
                    code_path=tmp_path,
                )
            ],
        )
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _ = _create_providers(app_model, graph, config, tmp_path)

        # Should have at least the Lambda provider
        assert any(p.name.startswith("lambda:") for p in providers.values())

    def test_empty_model_returns_empty(self, tmp_path):
        app_model = AppModel()
        graph = build_graph(app_model)
        config = LdkConfig(port=4000)
        providers, _ = _create_providers(app_model, graph, config, tmp_path)

        assert "__dynamodb_http__" not in providers


class TestDevCommand:
    """Tests for the dev command argument parsing."""

    def test_app_has_dev_command(self):
        from typer.testing import CliRunner

        from ldk.cli.main import app

        runner = CliRunner()
        result = runner.invoke(app, ["--help"])
        assert "dev" in result.output
