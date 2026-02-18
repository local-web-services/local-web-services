"""Integration test verifying all providers are created from the full-app fixture."""

from __future__ import annotations

from pathlib import Path

from lws.cli.ldk import _create_providers
from lws.config.loader import LdkConfig
from lws.graph.builder import build_graph
from lws.parser.assembly import parse_assembly

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "full-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestFullAppProviderCreation:
    def test_full_app_creates_all_expected_providers(self, tmp_path):
        # Arrange
        expected_provider_names = {"dynamodb", "sqs", "s3", "sns", "stepfunctions"}

        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9300)

        # Act
        providers, _chaos_configs, _ = _create_providers(app_model, graph, config, tmp_path)

        # Assert
        actual_provider_names = {p.name for p in providers.values()}

        for expected_name in expected_provider_names:
            assert expected_name in actual_provider_names
