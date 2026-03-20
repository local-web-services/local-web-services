"""Unit tests for AwsFakeResponse dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import AwsFakeResponse


class TestAwsFakeResponseDefaults:
    def test_defaults(self):
        # Arrange
        response = AwsFakeResponse()

        # Act
        actual_status = response.status
        actual_headers = response.headers
        actual_body = response.body
        actual_content_type = response.content_type
        actual_delay_ms = response.delay_ms

        # Assert
        expected_status = 200
        assert actual_status == expected_status, f"Expected {expected_status!r} but got {actual_status!r}"
        assert actual_headers == {}, "Expected {0!r} but got {1!r}".format({}, actual_headers)
        assert actual_body is None, f"Expected None but got {actual_body!r}"
        expected_content_type = "application/json"
        assert actual_content_type == expected_content_type, f"Expected {expected_content_type!r} but got {actual_content_type!r}"
        expected_delay_ms = 0
        assert actual_delay_ms == expected_delay_ms, f"Expected {expected_delay_ms!r} but got {actual_delay_ms!r}"
