"""Integration tests for cloud assembly parsing."""

from __future__ import annotations

from pathlib import Path

from lws.parser.assembly import parse_assembly

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
