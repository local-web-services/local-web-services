"""Unit tests for AwsMockResponse dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import AwsMockResponse


class TestAwsMockResponseDefaults:
    def test_defaults(self):
        # Arrange
        response = AwsMockResponse()

        # Act
        actual_status = response.status
        actual_headers = response.headers
        actual_body = response.body
        actual_content_type = response.content_type
        actual_delay_ms = response.delay_ms

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        assert actual_headers == {}
        assert actual_body is None
        expected_content_type = "application/json"
        assert actual_content_type == expected_content_type
        expected_delay_ms = 0
        assert actual_delay_ms == expected_delay_ms
