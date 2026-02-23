"""Unit tests for AwsIamAuthMiddleware identity header override."""

from __future__ import annotations

import httpx
from fastapi import FastAPI, Request, Response

from lws.config.loader import IamAuthConfig, IamAuthServiceConfig
from lws.providers._shared.aws_chaos import ErrorFormat
from lws.providers._shared.aws_iam_auth import (
    AwsIamAuthMiddleware,
    IamAuthBundle,
)
from lws.providers._shared.iam_identity_store import Identity, IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore


def _create_test_app(iam_auth: IamAuthBundle, service: str = "dynamodb") -> FastAPI:
    """Create a minimal FastAPI app with IAM auth middleware."""
    app = FastAPI()

    @app.post("/")
    async def handler(request: Request) -> Response:
        return Response(content='{"ok": true}', media_type="application/json")

    app.add_middleware(
        AwsIamAuthMiddleware,
        iam_auth_config=iam_auth.config,
        service=service,
        identity_store=iam_auth.identity_store,
        permissions_map=iam_auth.permissions_map,
        resource_policy_store=iam_auth.resource_policy_store,
        error_format=ErrorFormat.JSON,
    )
    return app


class TestIamAuthMiddlewareIdentityHeader:
    async def test_identity_header_override(self):
        # Arrange
        config = IamAuthConfig(
            mode="enforce",
            default_identity="nobody",
            services={"dynamodb": IamAuthServiceConfig(enabled=True)},
        )
        store = IdentityStore()
        store._identities["admin-user"] = Identity(
            name="admin-user",
            type="user",
            inline_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}],
                }
            ],
        )
        bundle = IamAuthBundle(
            config=config,
            identity_store=store,
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )
        app = _create_test_app(bundle)
        expected_status = 200
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
            response = await client.post(
                "/",
                headers={
                    "X-Amz-Target": "DynamoDB_20120810.GetItem",
                    "X-Lws-Identity": "admin-user",
                },
                json={"TableName": "T", "Key": {}},
            )

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status
