"""Integration tests for IAM auth middleware on S3 (XML errors)."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.config.loader import IamAuthConfig, IamAuthServiceConfig
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.iam_identity_store import Identity, IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


class TestIamAuthS3Enforce:
    """Verify IAM auth middleware returns 403 XML errors on S3."""

    @pytest.fixture
    def provider(self, tmp_path: Path):
        """Create S3 provider."""
        # Arrange
        return S3Provider(data_dir=tmp_path, buckets=["test-bucket"])

    @pytest.fixture
    def iam_auth_deny(self):
        """IAM auth bundle that denies PutObject."""
        # Arrange
        config = IamAuthConfig(
            mode="enforce",
            default_identity="reader",
            services={"s3": IamAuthServiceConfig(enabled=True)},
        )
        store = IdentityStore()
        store._identities["reader"] = Identity(
            name="reader",
            inline_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "s3:GetObject", "Resource": "*"},
                        {"Effect": "Allow", "Action": "s3:ListBucket", "Resource": "*"},
                        {"Effect": "Allow", "Action": "s3:ListAllMyBuckets", "Resource": "*"},
                    ],
                }
            ],
        )
        return IamAuthBundle(
            config=config,
            identity_store=store,
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )

    @pytest.fixture
    def app(self, provider, iam_auth_deny):
        """Create S3 app with IAM auth enforcement."""
        return create_s3_app(provider, iam_auth=iam_auth_deny)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_denies_put_object(self, client: httpx.AsyncClient):
        """PutObject should be denied with 403 XML error."""
        # Arrange
        expected_status = 403
        expected_code = "AccessDenied"

        # Act
        response = await client.put(
            "/test-bucket/test-key",
            content=b"test data",
        )

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status
        assert expected_code in response.text

    async def test_allows_get_object(self, client: httpx.AsyncClient):
        """GetObject should be allowed through."""
        # Arrange
        expected_status_not_denied = True

        # Act
        response = await client.get("/test-bucket/test-key")

        # Assert
        actual_not_denied = response.status_code != 403
        assert actual_not_denied == expected_status_not_denied
