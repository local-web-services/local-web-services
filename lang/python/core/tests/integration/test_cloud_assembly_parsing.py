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
        assert (
            actual_table_count == expected_table_count
        ), f"Expected {expected_table_count!r} but got {actual_table_count!r}"
        actual_table_name = app_model.tables[0].name
        assert (
            actual_table_name == expected_table_name
        ), f"Expected {expected_table_name!r} but got {actual_table_name!r}"

        actual_function_count = len(app_model.functions)
        assert (
            actual_function_count == expected_function_count
        ), f"Expected {expected_function_count!r} but got {actual_function_count!r}"
        actual_func_names = {f.name for f in app_model.functions}
        for expected_name in expected_function_names:
            assert (
                expected_name in actual_func_names
            ), f"Expected {expected_name!r} to be in {actual_func_names!r}"

        # Both functions should have TABLE_NAME env var
        for func in app_model.functions:
            assert (
                expected_env_var in func.environment
            ), f"Expected {expected_env_var!r} to be in {func.environment!r}"

    def test_parse_assembly_resolves_api_routes(self):
        # Arrange
        expected_methods = {"POST", "GET"}

        # Act
        app_model = parse_assembly(CDK_OUT)

        # Assert
        assert len(app_model.apis) >= 1, f"Expected {len(app_model.apis)!r} >= {1!r}"

        all_routes = [r for api in app_model.apis for r in api.routes]
        assert len(all_routes) >= 2, f"Expected {len(all_routes)!r} >= {2!r}"

        actual_methods = {r.method for r in all_routes}
        for expected_method in expected_methods:
            assert (
                expected_method in actual_methods
            ), f"Expected {expected_method!r} to be in {actual_methods!r}"
