"""Unit tests for extra routes detection in spec validator."""

from __future__ import annotations

from lws.providers.fakeserver.models import FakeResponse, FakeServerConfig, MatchCriteria, RouteRule
from lws.providers.fakeserver.validator import validate_against_spec


def _config_with_routes(routes: list[RouteRule]) -> FakeServerConfig:
    """Create a FakeServerConfig with the given routes."""
    config = FakeServerConfig(name="test")
    config.routes = routes
    return config


class TestExtraRoutes:
    def test_fake_route_not_in_spec(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text(
            "openapi: '3.0.0'\n" "info:\n" "  title: Test\n" "  version: '1.0'\n" "paths: {}\n"
        )
        route = RouteRule(
            path="/v1/extra",
            method="GET",
            responses=[(MatchCriteria(), FakeResponse(status=200))],
        )
        config = _config_with_routes([route])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        assert len(issues) > 0, f"Expected {len(issues)!r} > {0!r}"
        assert "not in spec" in issues[0].message, f'Expected {"not in spec"!r} to be in {issues[0].message!r}'
