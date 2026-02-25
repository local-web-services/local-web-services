"""Unit tests for AwsOperationFakeMiddleware response building."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI, Request
from starlette.responses import Response

from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeResponse,
    AwsFakeRule,
    AwsOperationFakeMiddleware,
)


class TestFakeMiddlewareResponse:
    @pytest.fixture
    def app_with_rule(self):
        def _factory(rule: AwsFakeRule):
            config = AwsFakeConfig(
                service="dynamodb",
                enabled=True,
                rules=[rule],
            )
            app = FastAPI()
            app.add_middleware(
                AwsOperationFakeMiddleware,
                fake_config=config,
                service="dynamodb",
            )

            @app.post("/")
            async def handler(request: Request):
                return Response(content='{"real": true}', media_type="application/json")

            return app

        return _factory

    async def test_custom_status_code_and_content_type(self, app_with_rule):
        # Arrange
        expected_status = 418
        expected_content_type = "text/plain"
        expected_body = "I am a teapot"
        rule = AwsFakeRule(
            operation="get-item",
            response=AwsFakeResponse(
                status=expected_status,
                body=expected_body,
                content_type=expected_content_type,
            ),
        )
        app = app_with_rule(rule)
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
                json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
            )

        # Assert
        assert response.status_code == expected_status
        actual_content_type = response.headers["content-type"]
        assert expected_content_type in actual_content_type
        actual_body = response.text
        assert actual_body == expected_body

    async def test_custom_headers_are_applied(self, app_with_rule):
        # Arrange
        expected_header_key = "x-custom-header"
        expected_header_value = "custom-value"
        rule = AwsFakeRule(
            operation="get-item",
            response=AwsFakeResponse(
                status=200,
                body={"ok": True},
                headers={expected_header_key: expected_header_value},
            ),
        )
        app = app_with_rule(rule)
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
                json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
            )

        # Assert
        actual_header_value = response.headers[expected_header_key]
        assert actual_header_value == expected_header_value

    async def test_dict_body_serialized_as_json(self, app_with_rule):
        # Arrange
        expected_key = "faked"
        expected_value = "data"
        rule = AwsFakeRule(
            operation="get-item",
            response=AwsFakeResponse(
                status=200,
                body={expected_key: expected_value},
            ),
        )
        app = app_with_rule(rule)
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
                json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
            )

        # Assert
        body = response.json()
        actual_value = body[expected_key]
        assert actual_value == expected_value

    async def test_string_body_returned_as_is(self, app_with_rule):
        # Arrange
        expected_body = "<xml>hello</xml>"
        rule = AwsFakeRule(
            operation="get-item",
            response=AwsFakeResponse(
                status=200,
                body=expected_body,
                content_type="application/xml",
            ),
        )
        app = app_with_rule(rule)
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
                json={"TableName": "TestTable", "Key": {"pk": {"S": "123"}}},
            )

        # Assert
        actual_body = response.text
        assert actual_body == expected_body
