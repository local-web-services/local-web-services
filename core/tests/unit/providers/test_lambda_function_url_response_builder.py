"""Tests for Lambda Function URL response builder."""

from __future__ import annotations

import base64
import json

from lws.providers.lambda_function_url.routes import build_http_response


class TestBuildHttpResponse:
    def test_structured_response(self):
        # Arrange
        expected_status = 200
        expected_body = "Hello, World!"
        lambda_result = {
            "statusCode": expected_status,
            "body": expected_body,
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status
        assert response.body == expected_body.encode()

    def test_response_with_headers(self):
        # Arrange
        expected_content_type = "text/plain"
        lambda_result = {
            "statusCode": 200,
            "headers": {"content-type": expected_content_type},
            "body": "ok",
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        actual_content_type = response.headers.get("content-type")
        assert actual_content_type == expected_content_type

    def test_base64_encoded_response(self):
        # Arrange
        raw_bytes = b"\x00\x01\x02\x03"
        encoded_body = base64.b64encode(raw_bytes).decode()
        lambda_result = {
            "statusCode": 200,
            "body": encoded_body,
            "isBase64Encoded": True,
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        assert response.body == raw_bytes

    def test_response_with_cookies(self):
        # Arrange
        expected_cookie = "session=abc123; Path=/"
        lambda_result = {
            "statusCode": 200,
            "body": "ok",
            "cookies": [expected_cookie],
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        actual_cookies = response.headers.getlist("set-cookie")
        assert expected_cookie in actual_cookies

    def test_none_response(self):
        # Arrange
        lambda_result = None

        # Act
        response = build_http_response(lambda_result)

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_string_response(self):
        # Arrange
        expected_body = "simple string"

        # Act
        response = build_http_response(expected_body)

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
        assert response.body == expected_body.encode()

    def test_dict_body_serialized_to_json(self):
        # Arrange
        body_dict = {"message": "hello"}
        lambda_result = {
            "statusCode": 200,
            "body": body_dict,
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        actual_body = json.loads(response.body)
        expected_message = "hello"
        actual_message = actual_body["message"]
        assert actual_message == expected_message

    def test_error_status_code(self):
        # Arrange
        expected_status = 404
        lambda_result = {
            "statusCode": expected_status,
            "body": "Not Found",
        }

        # Act
        response = build_http_response(lambda_result)

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status

    def test_default_status_code(self):
        # Arrange
        lambda_result = {"body": "no status"}

        # Act
        response = build_http_response(lambda_result)

        # Assert
        expected_status = 200
        actual_status = response.status_code
        assert actual_status == expected_status
