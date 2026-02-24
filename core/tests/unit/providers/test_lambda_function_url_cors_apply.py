"""Tests for apply_cors_headers in Lambda Function URL."""

from __future__ import annotations

from fastapi import Response

from lws.providers.lambda_function_url.routes import apply_cors_headers


class TestApplyCorsHeaders:
    def test_allow_all_origins(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"AllowOrigins": ["*"]}
        expected_origin = "*"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_origin = response.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin

    def test_specific_origin_match(self):
        # Arrange
        response = Response(status_code=200)
        expected_origin = "https://example.com"
        cors_config = {"AllowOrigins": [expected_origin]}

        # Act
        apply_cors_headers(response, cors_config, origin=expected_origin)

        # Assert
        actual_origin = response.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin

    def test_origin_not_in_list(self):
        # Arrange
        response = Response(status_code=200)
        expected_fallback = "https://allowed.com"
        cors_config = {"AllowOrigins": [expected_fallback]}

        # Act
        apply_cors_headers(response, cors_config, origin="https://other.com")

        # Assert
        actual_origin = response.headers.get("access-control-allow-origin")
        assert actual_origin == expected_fallback

    def test_allow_methods(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"AllowMethods": ["GET", "POST"]}
        expected_methods = "GET, POST"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_methods = response.headers.get("access-control-allow-methods")
        assert actual_methods == expected_methods

    def test_allow_headers(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"AllowHeaders": ["content-type", "authorization"]}
        expected_headers = "content-type, authorization"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_headers = response.headers.get("access-control-allow-headers")
        assert actual_headers == expected_headers

    def test_expose_headers(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"ExposeHeaders": ["x-custom"]}
        expected_expose = "x-custom"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_expose = response.headers.get("access-control-expose-headers")
        assert actual_expose == expected_expose

    def test_max_age(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"MaxAge": 3600}
        expected_max_age = "3600"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_max_age = response.headers.get("access-control-max-age")
        assert actual_max_age == expected_max_age

    def test_allow_credentials(self):
        # Arrange
        response = Response(status_code=200)
        cors_config = {"AllowCredentials": True}
        expected_credentials = "true"

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        actual_credentials = response.headers.get("access-control-allow-credentials")
        assert actual_credentials == expected_credentials

    def test_empty_cors_config(self):
        # Arrange
        response = Response(status_code=200)
        cors_config: dict = {}

        # Act
        apply_cors_headers(response, cors_config)

        # Assert
        assert "access-control-allow-origin" not in response.headers
