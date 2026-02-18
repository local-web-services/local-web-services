"""Unit tests for JSON error formatting."""

from __future__ import annotations

import json

from lws.providers._shared.aws_chaos import AwsErrorSpec, format_json_error


class TestFormatJsonError:
    def test_returns_json_with_type_and_message(self):
        # Arrange
        error = AwsErrorSpec(type="ResourceNotFoundException", message="Not found")

        # Act
        response = format_json_error(error)

        # Assert
        expected_status = 404
        assert response.status_code == expected_status
        body = json.loads(response.body)
        expected_type = "ResourceNotFoundException"
        actual_type = body["__type"]
        assert actual_type == expected_type
        expected_message = "Not found"
        actual_message = body["message"]
        assert actual_message == expected_message

    def test_uses_explicit_status_code(self):
        # Arrange
        expected_status = 503
        error = AwsErrorSpec(type="CustomError", message="Custom", status_code=expected_status)

        # Act
        response = format_json_error(error)

        # Assert
        assert response.status_code == expected_status

    def test_unknown_type_defaults_to_400(self):
        # Arrange
        error = AwsErrorSpec(type="UnknownCustomError", message="Unknown")

        # Act
        response = format_json_error(error)

        # Assert
        expected_status = 400
        assert response.status_code == expected_status
