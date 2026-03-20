"""Unit tests for generate_route_yaml in DSL parser."""

from __future__ import annotations

from lws.providers.fakeserver.dsl import generate_route_yaml


class TestGenerateRouteYaml:
    def test_basic_route(self):
        # Arrange
        expected_path = "/v1/users"
        expected_method = "GET"

        # Act
        actual = generate_route_yaml("/v1/users", method="GET", status=200)

        # Assert
        assert expected_path in actual, f"Expected {expected_path!r} to be in {actual!r}"
        assert expected_method in actual, f"Expected {expected_method!r} to be in {actual!r}"
