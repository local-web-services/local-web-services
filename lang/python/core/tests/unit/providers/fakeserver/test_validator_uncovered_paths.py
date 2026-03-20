"""Unit tests for uncovered paths detection in spec validator."""

from __future__ import annotations

from lws.providers.fakeserver.models import FakeResponse, FakeServerConfig, MatchCriteria, RouteRule
from lws.providers.fakeserver.validator import validate_against_spec


def _config_with_routes(routes: list[RouteRule]) -> FakeServerConfig:
    """Create a FakeServerConfig with the given routes."""
    config = FakeServerConfig(name="test")
    config.routes = routes
    return config


class TestUncoveredPaths:
    def test_spec_path_not_in_fake(self, tmp_path):
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
        assert len(issues) > 0, f"Expected {len(issues)!r} > {0!r}"
        expected_level = "WARN"
        actual_level = issues[0].level
        assert (
            actual_level == expected_level
        ), f"Expected {expected_level!r} but got {actual_level!r}"

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
            responses=[(MatchCriteria(), FakeResponse(status=200))],
        )
        config = _config_with_routes([route])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        assert len(issues) == 0, f"Expected {0!r} but got {len(issues)!r}"
