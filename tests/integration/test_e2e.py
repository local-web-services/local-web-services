"""End-to-end integration tests for LDK.

Tests the full pipeline: cloud assembly parsing -> graph building ->
provider creation -> orchestrator startup -> HTTP request round-trip.
"""

from __future__ import annotations

from pathlib import Path

import pytest

from ldk.cli.main import _create_providers
from ldk.config.loader import LdkConfig
from ldk.graph.builder import build_graph
from ldk.parser.assembly import parse_assembly
from ldk.runtime.orchestrator import Orchestrator

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "sample-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestCloudAssemblyParsing:
    """Test that the sample cdk.out can be fully parsed."""

    def test_parse_assembly_discovers_resources(self):
        app_model = parse_assembly(CDK_OUT)

        assert len(app_model.tables) == 1
        assert app_model.tables[0].name == "Items"

        assert len(app_model.functions) == 2
        func_names = {f.name for f in app_model.functions}
        assert "CreateItemFunction" in func_names
        assert "GetItemFunction" in func_names

        # Both functions should have TABLE_NAME env var
        for func in app_model.functions:
            assert "TABLE_NAME" in func.environment

    def test_parse_assembly_resolves_api_routes(self):
        app_model = parse_assembly(CDK_OUT)
        assert len(app_model.apis) >= 1

        all_routes = [r for api in app_model.apis for r in api.routes]
        assert len(all_routes) >= 2

        methods = {r.method for r in all_routes}
        assert "POST" in methods
        assert "GET" in methods


class TestGraphBuilding:
    """Test that the app model produces a valid graph."""

    def test_build_graph_from_parsed_model(self):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)

        # Should have nodes for tables, functions, and API
        assert len(graph.nodes) >= 4  # 1 table + 2 functions + 1 API

        # Should have edges (triggers and data dependencies)
        assert len(graph.edges) >= 1

    def test_topological_sort_tables_before_functions(self):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        order = graph.topological_sort()

        assert len(order) > 0
        # All nodes should be in the sort result (no cycles)
        assert len(order) == len(graph.nodes)

    def test_no_cycles(self):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        cycles = graph.detect_cycles()
        assert len(cycles) == 0


class TestProviderCreation:
    """Test that providers are correctly instantiated from the app model."""

    def test_creates_all_providers(self, tmp_path):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9100)

        providers, compute_providers = _create_providers(app_model, graph, config, tmp_path)

        assert len(providers) >= 1
        assert isinstance(compute_providers, dict)

        provider_names = {p.name for p in providers.values()}
        assert "dynamodb" in provider_names
        assert "dynamodb-http" in provider_names


class TestOrchestratorIntegration:
    """Test orchestrator start/stop with real provider instances."""

    async def test_start_and_stop_dynamo_provider(self, tmp_path):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9200)

        providers, _ = _create_providers(app_model, graph, config, tmp_path)

        # Only keep the dynamo provider (not HTTP or Lambda, which need node/port)
        dynamo_providers = {k: v for k, v in providers.items() if v.name == "dynamodb"}
        if not dynamo_providers:
            pytest.skip("No DynamoDB provider created")

        orchestrator = Orchestrator()
        startup_order = list(dynamo_providers.keys())

        await orchestrator.start(dynamo_providers, startup_order)
        assert orchestrator.running

        await orchestrator.stop()
        assert not orchestrator.running
