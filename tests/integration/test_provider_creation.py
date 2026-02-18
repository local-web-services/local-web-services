"""Integration tests for provider creation."""

from __future__ import annotations

from pathlib import Path

from lws.cli.ldk import _create_providers
from lws.config.loader import LdkConfig
from lws.graph.builder import build_graph
from lws.parser.assembly import parse_assembly

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "sample-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestProviderCreation:
    """Test that providers are correctly instantiated from the app model."""

    def test_creates_all_providers(self, tmp_path):
        # Arrange
        expected_dynamodb = "dynamodb"
        expected_dynamodb_http = "dynamodb-http"

        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9100)

        # Act
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Assert
        assert len(providers) >= 1

        actual_provider_names = {p.name for p in providers.values()}
        assert expected_dynamodb in actual_provider_names
        assert expected_dynamodb_http in actual_provider_names
