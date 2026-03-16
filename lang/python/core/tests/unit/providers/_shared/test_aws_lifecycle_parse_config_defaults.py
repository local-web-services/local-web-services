"""Unit tests for parse_lifecycle_config default values."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import parse_lifecycle_config


class TestParseLifecycleConfigDefaults:
    def test_parse_lifecycle_config_defaults(self):
        # Arrange
        raw: dict = {}
        expected_enabled = False
        expected_create_dwell_ms = 0
        expected_delete_dwell_ms = 0

        # Act
        config = parse_lifecycle_config(raw)

        # Assert
        actual_enabled = config.enabled
        actual_create_dwell_ms = config.create_dwell_ms
        actual_delete_dwell_ms = config.delete_dwell_ms
        assert actual_enabled == expected_enabled
        assert actual_create_dwell_ms == expected_create_dwell_ms
        assert actual_delete_dwell_ms == expected_delete_dwell_ms
