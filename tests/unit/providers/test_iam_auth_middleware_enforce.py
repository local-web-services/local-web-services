"""Unit tests for AwsIamAuthMiddleware in enforce mode."""

from __future__ import annotations

import httpx
import pytest
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


def _make_identity_store_with_admin() -> IdentityStore:
    """Create an identity store with an admin user."""
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
    return store


def _make_identity_store_readonly() -> IdentityStore:
    """Create an identity store with a read-only user."""
    store = IdentityStore()
    store._identities["readonly-user"] = Identity(
        name="readonly-user",
        type="user",
        inline_policies=[
            {
                "Version": "2012-10-17",
                "Statement": [{"Effect": "Allow", "Action": "dynamodb:GetItem", "Resource": "*"}],
            }
        ],
    )
    return store


class TestIamAuthMiddlewareEnforce:
    @pytest.fixture
    def denied_bundle(self):
        """Bundle where default identity has no permissions."""
        # Arrange
        config = IamAuthConfig(
            mode="enforce",
            default_identity="readonly-user",
            services={"dynamodb": IamAuthServiceConfig(enabled=True)},
        )
        return IamAuthBundle(
            config=config,
            identity_store=_make_identity_store_readonly(),
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )

    @pytest.fixture
    def allowed_bundle(self):
        """Bundle where default identity has admin permissions."""
        # Arrange
        config = IamAuthConfig(
            mode="enforce",
            default_identity="admin-user",
            services={"dynamodb": IamAuthServiceConfig(enabled=True)},
        )
        return IamAuthBundle(
            config=config,
            identity_store=_make_identity_store_with_admin(),
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )

    async def test_denies_unauthorized_operation(self, denied_bundle):
        # Arrange
        app = _create_test_app(denied_bundle)
        expected_status = 403
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
                json={"TableName": "T", "Item": {}},
            )

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status

    async def test_allows_authorized_operation(self, allowed_bundle):
        # Arrange
        app = _create_test_app(allowed_bundle)
        expected_status = 200
        transport = httpx.ASGITransport(app=app)

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://test") as client:
            response = await client.post(
                "/",
                headers={"X-Amz-Target": "DynamoDB_20120810.GetItem"},
                json={"TableName": "T", "Key": {}},
            )

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status
