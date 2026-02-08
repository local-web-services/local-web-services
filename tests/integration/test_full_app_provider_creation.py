"""Integration test verifying all providers are created from the full-app fixture."""

from __future__ import annotations

from pathlib import Path

from ldk.cli.main import _create_providers
from ldk.config.loader import LdkConfig
from ldk.graph.builder import build_graph
from ldk.parser.assembly import parse_assembly

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "full-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestFullAppProviderCreation:
    def test_full_app_creates_all_expected_providers(self, tmp_path):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        config = LdkConfig(port=9300)

        providers, compute_providers = _create_providers(app_model, graph, config, tmp_path)

        provider_names = {p.name for p in providers.values()}

        assert "dynamodb" in provider_names
        assert "sqs" in provider_names
        assert "s3" in provider_names
        assert "sns" in provider_names
        assert "stepfunctions" in provider_names
