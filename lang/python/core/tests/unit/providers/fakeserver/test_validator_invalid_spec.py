"""Unit tests for invalid spec handling in spec validator."""

from __future__ import annotations

from lws.providers.fakeserver.models import FakeServerConfig
from lws.providers.fakeserver.validator import validate_against_spec


def _config_with_routes(routes: list) -> FakeServerConfig:
    """Create a FakeServerConfig with the given routes."""
    config = FakeServerConfig(name="test")
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
