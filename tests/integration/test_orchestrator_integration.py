"""Integration tests for orchestrator start/stop."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.cli.ldk import _create_providers
from lws.config.loader import LdkConfig
from lws.graph.builder import build_graph
from lws.parser.assembly import parse_assembly
from lws.runtime.orchestrator import Orchestrator

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "sample-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestOrchestratorIntegration:
    """Test orchestrator start/stop with real provider instances."""

    async def test_start_and_stop_dynamo_provider(self, tmp_path):
        # Arrange
        expected_provider_name = "dynamodb"

        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9200)

        providers, _chaos_configs = _create_providers(app_model, graph, config, tmp_path)

        # Only keep the dynamo provider (not HTTP or Lambda, which need node/port)
        dynamo_providers = {k: v for k, v in providers.items() if v.name == expected_provider_name}
        if not dynamo_providers:
            pytest.skip("No DynamoDB provider created")

        orchestrator = Orchestrator()
        startup_order = list(dynamo_providers.keys())

        # Act - Start
        await orchestrator.start(dynamo_providers, startup_order)

        # Assert - Running
        assert orchestrator.running

        # Act - Stop
        await orchestrator.stop()

        # Assert - Stopped
        assert not orchestrator.running
