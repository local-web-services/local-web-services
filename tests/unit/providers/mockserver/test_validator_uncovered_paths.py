"""Unit tests for uncovered paths detection in spec validator."""

from __future__ import annotations

from lws.providers.mockserver.models import MatchCriteria, MockResponse, MockServerConfig, RouteRule
from lws.providers.mockserver.validator import validate_against_spec


def _config_with_routes(routes: list[RouteRule]) -> MockServerConfig:
    """Create a MockServerConfig with the given routes."""
    config = MockServerConfig(name="test")
    config.routes = routes
    return config


class TestUncoveredPaths:
    def test_spec_path_not_in_mock(self, tmp_path):
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
        config = _config_with_routes([])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        assert len(issues) > 0
        expected_level = "WARN"
        actual_level = issues[0].level
        assert actual_level == expected_level

    def test_all_paths_covered(self, tmp_path):
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
            responses=[(MatchCriteria(), MockResponse(status=200))],
        )
        config = _config_with_routes([route])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        assert len(issues) == 0
