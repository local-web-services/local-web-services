"""Tests for _collect_lambda_urls in assembly."""

from __future__ import annotations

from lws.parser.assembly import _collect_lambda_urls
from lws.parser.ref_resolver import RefResolver
from lws.parser.template_parser import CfnResource


class TestCollectLambdaUrls:
    def test_collects_lambda_url_with_string_arn(self):
        # Arrange
        expected_function_name = "MyFunction"
        expected_auth_type = "NONE"
        resources = [
            CfnResource(
                logical_id="MyFunctionUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": (
                        f"arn:aws:lambda:us-east-1:123:function:{expected_function_name}"
                    ),
                    "AuthType": expected_auth_type,
                },
            ),
        ]
        resolver = RefResolver(resource_map={}, resource_types={})

        # Act
        result = _collect_lambda_urls(resources, resolver)

        # Assert
        assert len(result) == 1, f"Expected {1!r} but got {len(result)!r}"
        actual_url = result[0]
        expected_logical_id = "MyFunctionUrl"
        assert (
            actual_url.function_name == expected_function_name
        ), f"Expected {expected_function_name!r} but got {actual_url.function_name!r}"
        assert (
            actual_url.auth_type == expected_auth_type
        ), f"Expected {expected_auth_type!r} but got {actual_url.auth_type!r}"
        assert (
            actual_url.logical_id == expected_logical_id
        ), f"Expected {expected_logical_id!r} but got {actual_url.logical_id!r}"

    def test_collects_lambda_url_with_ref(self):
        # Arrange
        expected_function_name = "HandlerFunction"
        resources = [
            CfnResource(
                logical_id="HandlerFunction",
                resource_type="AWS::Lambda::Function",
                properties={"Handler": "index.handler"},
            ),
            CfnResource(
                logical_id="HandlerUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": {"Fn::GetAtt": ["HandlerFunction", "Arn"]},
                    "AuthType": "NONE",
                },
            ),
        ]
        resolver = RefResolver(
            resource_map={
                "HandlerFunction": (
                    f"arn:aws:lambda:us-east-1:000:function:{expected_function_name}"
                ),
            },
            resource_types={"HandlerFunction": "AWS::Lambda::Function"},
        )

        # Act
        result = _collect_lambda_urls(resources, resolver)

        # Assert
        assert len(result) == 1, f"Expected {1!r} but got {len(result)!r}"
        actual_function_name = result[0].function_name
        assert (
            actual_function_name == expected_function_name
        ), f"Expected {expected_function_name!r} but got {actual_function_name!r}"

    def test_collects_cors_config(self):
        # Arrange
        expected_cors = {
            "AllowOrigins": ["https://example.com"],
            "AllowMethods": ["GET"],
        }
        resources = [
            CfnResource(
                logical_id="CorsUrl",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:Fn",
                    "Cors": expected_cors,
                },
            ),
        ]
        resolver = RefResolver(resource_map={}, resource_types={})

        # Act
        result = _collect_lambda_urls(resources, resolver)

        # Assert
        actual_cors = result[0].cors
        assert actual_cors == expected_cors, f"Expected {expected_cors!r} but got {actual_cors!r}"

    def test_skips_non_url_resources(self):
        # Arrange
        resources = [
            CfnResource("Fn1", "AWS::Lambda::Function", {}),
            CfnResource("T1", "AWS::DynamoDB::Table", {}),
        ]
        resolver = RefResolver(resource_map={}, resource_types={})

        # Act
        result = _collect_lambda_urls(resources, resolver)

        # Assert
        assert result == [], f"Expected {[]!r} but got {result!r}"

    def test_collects_multiple_urls(self):
        # Arrange
        resources = [
            CfnResource(
                logical_id="Url1",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:Fn1",
                },
            ),
            CfnResource(
                logical_id="Url2",
                resource_type="AWS::Lambda::Url",
                properties={
                    "TargetFunctionArn": "arn:aws:lambda:us-east-1:123:function:Fn2",
                },
            ),
        ]
        resolver = RefResolver(resource_map={}, resource_types={})

        # Act
        result = _collect_lambda_urls(resources, resolver)

        # Assert
        assert len(result) == 2, f"Expected {2!r} but got {len(result)!r}"
