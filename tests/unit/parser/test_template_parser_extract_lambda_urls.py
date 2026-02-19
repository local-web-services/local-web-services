"""Tests for extract_lambda_urls in template_parser."""

from __future__ import annotations

from lws.parser.template_parser import (
    CfnResource,
    extract_lambda_urls,
)


class TestExtractLambdaUrls:
    def test_basic_lambda_url(self):
        # Arrange
        expected_auth_type = "NONE"
        expected_invoke_mode = "BUFFERED"
        resources = [
            CfnResource(
                logical_id="MyFunctionUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": {"Fn::GetAtt": ["MyFunction", "Arn"]},
                    "AuthType": expected_auth_type,
                    "InvokeMode": expected_invoke_mode,
                },
            ),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        assert len(result) == 1
        actual_url = result[0]
        assert actual_url.auth_type == expected_auth_type
        assert actual_url.invoke_mode == expected_invoke_mode
        assert actual_url.target_function_arn == {"Fn::GetAtt": ["MyFunction", "Arn"]}

    def test_lambda_url_with_cors(self):
        # Arrange
        expected_cors = {
            "AllowOrigins": ["*"],
            "AllowMethods": ["GET", "POST"],
            "AllowHeaders": ["content-type"],
        }
        resources = [
            CfnResource(
                logical_id="UrlWithCors",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:fn",
                    "AuthType": "NONE",
                    "Cors": expected_cors,
                },
            ),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        actual_cors = result[0].cors
        assert actual_cors == expected_cors

    def test_lambda_url_with_iam_auth(self):
        # Arrange
        expected_auth_type = "AWS_IAM"
        resources = [
            CfnResource(
                logical_id="IamUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:fn",
                    "AuthType": expected_auth_type,
                },
            ),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        actual_auth_type = result[0].auth_type
        assert actual_auth_type == expected_auth_type

    def test_lambda_url_defaults(self):
        # Arrange
        expected_auth_type = "NONE"
        expected_invoke_mode = "BUFFERED"
        resources = [
            CfnResource(
                logical_id="DefaultUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:fn",
                },
            ),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        actual_url = result[0]
        assert actual_url.auth_type == expected_auth_type
        assert actual_url.invoke_mode == expected_invoke_mode
        assert actual_url.cors is None

    def test_skips_non_lambda_url(self):
        # Arrange
        resources = [
            CfnResource("Fn1", "AWS::Lambda::Function", {"Handler": "h"}),
            CfnResource("T1", "AWS::DynamoDB::Table", {}),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        assert result == []

    def test_response_stream_invoke_mode(self):
        # Arrange
        expected_invoke_mode = "RESPONSE_STREAM"
        resources = [
            CfnResource(
                logical_id="StreamUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:fn",
                    "InvokeMode": expected_invoke_mode,
                },
            ),
        ]

        # Act
        result = extract_lambda_urls(resources)

        # Assert
        actual_invoke_mode = result[0].invoke_mode
        assert actual_invoke_mode == expected_invoke_mode
