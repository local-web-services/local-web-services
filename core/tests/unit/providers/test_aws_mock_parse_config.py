"""Unit tests for parse_mock_response."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import parse_mock_response


class TestParseMockResponse:
    def test_parses_full_config(self):
        # Arrange
        raw = {
            "status": 404,
            "headers": {"x-custom": "value"},
            "body": {"error": "not found"},
            "content_type": "application/xml",
            "delay_ms": 150,
        }

        # Act
        response = parse_mock_response(raw)

        # Assert
        expected_status = 404
        assert response.status == expected_status
        expected_header_value = "value"
        assert response.headers["x-custom"] == expected_header_value
        expected_body = {"error": "not found"}
        assert response.body == expected_body
        expected_content_type = "application/xml"
        assert response.content_type == expected_content_type
        expected_delay_ms = 150
        assert response.delay_ms == expected_delay_ms

    def test_parses_empty_dict(self):
        # Arrange
        raw = {}

        # Act
        response = parse_mock_response(raw)

        # Assert
        expected_status = 200
        assert response.status == expected_status
        assert response.headers == {}
        assert response.body is None
        expected_content_type = "application/json"
        assert response.content_type == expected_content_type
        expected_delay_ms = 0
        assert response.delay_ms == expected_delay_ms
