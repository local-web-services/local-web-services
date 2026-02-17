"""Unit tests for invalid spec handling in spec validator."""

from __future__ import annotations

from lws.providers.mockserver.models import MockServerConfig
from lws.providers.mockserver.validator import validate_against_spec


def _config_with_routes(routes: list) -> MockServerConfig:
    """Create a MockServerConfig with the given routes."""
    config = MockServerConfig(name="test")
    config.routes = routes
    return config


class TestInvalidSpec:
    def test_empty_spec(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text("")
        config = _config_with_routes([])

        # Act
        issues = validate_against_spec(config, spec)

        # Assert
        assert len(issues) == 1
        expected_level = "ERROR"
        actual_level = issues[0].level
        assert actual_level == expected_level
