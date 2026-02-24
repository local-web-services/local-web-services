"""Integration tests for cloud assembly parsing."""

from __future__ import annotations

from pathlib import Path

from lws.parser.assembly import parse_assembly

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "sample-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestCloudAssemblyParsing:
    """Test that the sample cdk.out can be fully parsed."""

    def test_parse_assembly_discovers_resources(self):
        # Arrange
        expected_table_count = 1
        expected_table_name = "Items"
        expected_function_count = 2
        expected_function_names = {"CreateItemFunction", "GetItemFunction"}
        expected_env_var = "TABLE_NAME"

        # Act
        app_model = parse_assembly(CDK_OUT)

        # Assert
        actual_table_count = len(app_model.tables)
        assert actual_table_count == expected_table_count
        actual_table_name = app_model.tables[0].name
        assert actual_table_name == expected_table_name

        actual_function_count = len(app_model.functions)
        assert actual_function_count == expected_function_count
        actual_func_names = {f.name for f in app_model.functions}
        for expected_name in expected_function_names:
            assert expected_name in actual_func_names

        # Both functions should have TABLE_NAME env var
        for func in app_model.functions:
            assert expected_env_var in func.environment

    def test_parse_assembly_resolves_api_routes(self):
        # Arrange
        expected_methods = {"POST", "GET"}

        # Act
        app_model = parse_assembly(CDK_OUT)

        # Assert
        assert len(app_model.apis) >= 1

        all_routes = [r for api in app_model.apis for r in api.routes]
        assert len(all_routes) >= 2

        actual_methods = {r.method for r in all_routes}
        for expected_method in expected_methods:
            assert expected_method in actual_methods
