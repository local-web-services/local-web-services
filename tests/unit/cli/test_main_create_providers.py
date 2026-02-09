"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _create_providers,
)
from lws.config.loader import LdkConfig
from lws.graph.builder import build_graph
from lws.parser.assembly import (
    AppModel,
    DynamoTable,
    LambdaFunction,
)


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
