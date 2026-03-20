"""Unit tests for parse_fake_response."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import parse_fake_response


class TestParseFakeResponse:
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
        response = parse_fake_response(raw)

        # Assert
        expected_status = 404
        assert (
            response.status == expected_status
        ), f"Expected {expected_status!r} but got {response.status!r}"
        expected_header_value = "value"
        assert (
            response.headers["x-custom"] == expected_header_value
        ), f'Expected {expected_header_value!r} but got {response.headers["x-custom"]!r}'
        expected_body = {"error": "not found"}
        assert (
            response.body == expected_body
        ), f"Expected {expected_body!r} but got {response.body!r}"
        expected_content_type = "application/xml"
        assert (
            response.content_type == expected_content_type
        ), f"Expected {expected_content_type!r} but got {response.content_type!r}"
        expected_delay_ms = 150
        assert (
            response.delay_ms == expected_delay_ms
        ), f"Expected {expected_delay_ms!r} but got {response.delay_ms!r}"

    def test_parses_empty_dict(self):
        # Arrange
        raw = {}

        # Act
        response = parse_fake_response(raw)

        # Assert
        expected_status = 200
        assert (
            response.status == expected_status
        ), f"Expected {expected_status!r} but got {response.status!r}"
        assert response.headers == {}, f"Expected {({})!r} but got {response.headers!r}"
        assert response.body is None, f"Expected None but got {response.body!r}"
        expected_content_type = "application/json"
        assert (
            response.content_type == expected_content_type
        ), f"Expected {expected_content_type!r} but got {response.content_type!r}"
        expected_delay_ms = 0
        assert (
            response.delay_ms == expected_delay_ms
        ), f"Expected {expected_delay_ms!r} but got {response.delay_ms!r}"
