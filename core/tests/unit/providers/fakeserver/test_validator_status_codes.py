"""Unit tests for status code validation in spec validator."""

from __future__ import annotations

from lws.providers.fakeserver.models import MatchCriteria, FakeResponse, FakeServerConfig, RouteRule
from lws.providers.fakeserver.validator import validate_against_spec


def _config_with_routes(routes: list[RouteRule]) -> FakeServerConfig:
    """Create a FakeServerConfig with the given routes."""
    config = FakeServerConfig(name="test")
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
            responses=[(MatchCriteria(), FakeResponse(status=404))],
        )
        config = _config_with_routes([route])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        status_issues = [i for i in issues if "Status" in i.message]
        assert len(status_issues) > 0
