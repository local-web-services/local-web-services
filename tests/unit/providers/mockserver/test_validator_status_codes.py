"""Unit tests for status code validation in spec validator."""

from __future__ import annotations

from lws.providers.mockserver.models import MatchCriteria, MockResponse, MockServerConfig, RouteRule
from lws.providers.mockserver.validator import validate_against_spec


def _config_with_routes(routes: list[RouteRule]) -> MockServerConfig:
    """Create a MockServerConfig with the given routes."""
    config = MockServerConfig(name="test")
    config.routes = routes
    return config


class TestStatusCodes:
    def test_status_code_not_in_spec(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n"
            "info:\n"
            "  title: Test\n"
            "  version: '1.0'\n"
            "paths:\n"
            "  /v1/users:\n"
            "    get:\n"
            "      responses:\n"
            "        '200':\n"
            "          description: OK\n"
        )
        route = RouteRule(
            path="/v1/users",
            method="GET",
            responses=[(MatchCriteria(), MockResponse(status=404))],
        )
        config = _config_with_routes([route])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        status_issues = [i for i in issues if "Status" in i.message]
        assert len(status_issues) > 0
