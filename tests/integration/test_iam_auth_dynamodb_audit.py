"""Integration tests for IAM auth middleware audit mode on DynamoDB."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.config.loader import IamAuthConfig, IamAuthServiceConfig
from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.iam_identity_store import Identity, IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


class TestIamAuthDynamoDbAudit:
    """Verify audit mode allows requests through."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create DynamoDB provider."""
        # Arrange
        p = SqliteDynamoProvider(
            data_dir=tmp_path,
            tables=[
                TableConfig(
                    table_name="TestTable",
                    key_schema=KeySchema(partition_key=KeyAttribute(name="pk", type="S")),
                )
            ],
        )
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def iam_auth_audit(self):
        """IAM auth bundle in audit mode."""
        # Arrange
        config = IamAuthConfig(
            mode="audit",
            default_identity="reader",
            services={"dynamodb": IamAuthServiceConfig(enabled=True)},
        )
        store = IdentityStore()
        store._identities["reader"] = Identity(
            name="reader",
            inline_policies=[
                {
                    "Version": "2012-10-17",
                    "Statement": [
                        {"Effect": "Allow", "Action": "dynamodb:GetItem", "Resource": "*"}
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
    def app(self, provider, iam_auth_audit):
        """Create DynamoDB app with IAM auth in audit mode."""
        return create_dynamodb_app(provider, iam_auth=iam_auth_audit)

    @pytest.fixture
    async def client(self, app):
        """Create async HTTP client."""
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_audit_mode_allows_denied_operation(self, client: httpx.AsyncClient):
        """PutItem should pass through in audit mode even without permission."""
        # Arrange
        expected_status = 200

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "DynamoDB_20120810.PutItem"},
            json={"TableName": "TestTable", "Item": {"pk": {"S": "1"}}},
        )

        # Assert
        actual_status = response.status_code
        assert actual_status == expected_status
