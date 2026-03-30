"""Tests for API Gateway V1 Lambda proxy URI parsing."""

from __future__ import annotations

from lws.providers.apigateway._apigateway_v1_dispatch import _parse_integration_uri


class TestApiGatewayV1LambdaProxyUri:
    """Tests for Lambda proxy integration URI parsing."""

    def test_lambda_proxy_uri_parsed_correctly(self) -> None:
        # Arrange
        uri = (
            "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31"
            "/functions/arn:aws:lambda:us-east-1:000000000000:function:my-function/invocations"
        )
        expected_service = "lambda"
        expected_function = "my-function"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, "Expected a parsed descriptor but got None"
        actual_service = actual_result["service"]
        assert (
            actual_service == expected_service
        ), f"Expected {expected_service!r} but got {actual_service!r}"
        actual_function = actual_result["function_name"]
        assert (
            actual_function == expected_function
        ), f"Expected {expected_function!r} but got {actual_function!r}"

    def test_non_lambda_uri_not_parsed_as_lambda(self) -> None:
        # Arrange
        uri = "arn:aws:apigateway:us-east-1:dynamodb:action/PutItem"
        expected_service = "dynamodb"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, "Expected a parsed descriptor but got None"
        actual_service = actual_result["service"]
        assert (
            actual_service == expected_service
        ), f"Expected {expected_service!r} but got {actual_service!r}"

    def test_unknown_uri_returns_none(self) -> None:
        # Arrange
        uri = "arn:aws:apigateway:us-east-1:unknown:action/DoThing"
        expected_result = None

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"
