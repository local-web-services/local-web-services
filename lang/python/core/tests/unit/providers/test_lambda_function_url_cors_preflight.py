"""Tests for build_cors_preflight_response in Lambda Function URL."""

from __future__ import annotations

from lws.providers.lambda_function_url.routes import build_cors_preflight_response


class TestBuildCorsPreflightResponse:
    def test_preflight_status(self):
        # Arrange
        cors_config = {"AllowOrigins": ["*"], "AllowMethods": ["GET", "POST"]}

        # Act
        response = build_cors_preflight_response(cors_config)

        # Assert
        expected_status = 204
        actual_status = response.status_code
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )

    def test_preflight_includes_cors_headers(self):
        # Arrange
        expected_origin = "*"
        cors_config = {
            "AllowOrigins": ["*"],
            "AllowMethods": ["GET", "POST"],
            "AllowHeaders": ["content-type"],
        }

        # Act
        response = build_cors_preflight_response(cors_config)

        # Assert
        actual_origin = response.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin, (
            f"Expected {expected_origin!r} but got {actual_origin!r}"
        )
        assert "access-control-allow-methods" in response.headers, (
            f'Expected {"access-control-allow-methods"!r} to be in {response.headers!r}'
        )
        assert "access-control-allow-headers" in response.headers, (
            f'Expected {"access-control-allow-headers"!r} to be in {response.headers!r}'
        )
