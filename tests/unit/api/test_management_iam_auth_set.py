"""Unit tests for the IAM auth POST management endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.config.loader import IamAuthConfig
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.iam_identity_store import IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore
from lws.runtime.orchestrator import Orchestrator


def _make_bundle(mode: str = "disabled") -> IamAuthBundle:
    """Build a minimal IamAuthBundle for testing."""
    config = IamAuthConfig(mode=mode)
    return IamAuthBundle(
        config=config,
        identity_store=IdentityStore(None),
        permissions_map=PermissionsMap(None),
        resource_policy_store=ResourcePolicyStore(None),
    )


@pytest.fixture
def client_with_bundle():
    """Create a test client with an IAM auth bundle present."""
    orchestrator = Orchestrator()
    bundle = _make_bundle(mode="disabled")
    router = create_management_router(
        orchestrator=orchestrator,
        iam_auth_bundle=bundle,
    )
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


@pytest.fixture
def client_without_bundle():
    """Create a test client with no IAM auth bundle."""
    orchestrator = Orchestrator()
    router = create_management_router(
        orchestrator=orchestrator,
        iam_auth_bundle=None,
    )
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementIamAuthSet:
    """Tests for POST /_ldk/iam-auth."""

    def test_post_returns_400_when_no_bundle(self, client_without_bundle):
        # Arrange
        expected_status_code = 400

        # Act
        resp = client_without_bundle.post("/_ldk/iam-auth", json={})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_post_returns_error_message_when_no_bundle(self, client_without_bundle):
        # Arrange
        expected_error = "IAM auth not configured"

        # Act
        resp = client_without_bundle.post("/_ldk/iam-auth", json={})

        # Assert
        data = resp.json()
        actual_error = data["error"]
        assert actual_error == expected_error

    def test_post_updates_global_mode(self, client_with_bundle):
        # Arrange
        expected_mode = "audit"

        # Act
        resp = client_with_bundle.post("/_ldk/iam-auth", json={"mode": "audit"})

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        actual_mode = data["config"]["mode"]
        assert actual_mode == expected_mode

    def test_post_updates_service_mode(self, client_with_bundle):
        # Arrange
        expected_service_mode = "enforce"

        # Act
        resp = client_with_bundle.post(
            "/_ldk/iam-auth",
            json={"services": {"dynamodb": {"mode": "enforce"}}},
        )

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        actual_service_mode = data["config"]["services"]["dynamodb"]["mode"]
        assert actual_service_mode == expected_service_mode

    def test_post_returns_config_in_response(self, client_with_bundle):
        # Arrange
        expected_key = "config"

        # Act
        resp = client_with_bundle.post("/_ldk/iam-auth", json={})

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        assert expected_key in data

    def test_post_updates_default_identity(self, client_with_bundle):
        # Arrange
        expected_identity = "test-user"

        # Act
        resp = client_with_bundle.post("/_ldk/iam-auth", json={"default_identity": "test-user"})

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        actual_identity = data["config"]["default_identity"]
        assert actual_identity == expected_identity

    def test_post_creates_new_service_config_when_absent(self, client_with_bundle):
        # Arrange
        expected_mode = "audit"

        # Act
        resp = client_with_bundle.post(
            "/_ldk/iam-auth",
            json={"services": {"ssm": {"mode": "audit"}}},
        )

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        actual_mode = data["config"]["services"]["ssm"]["mode"]
        assert actual_mode == expected_mode

    def test_post_service_disabled_mode_sets_mode(self, client_with_bundle):
        # Arrange
        expected_mode = "disabled"

        # Act
        resp = client_with_bundle.post(
            "/_ldk/iam-auth",
            json={"services": {"dynamodb": {"mode": "disabled"}}},
        )

        # Assert
        assert resp.status_code == 200
        data = resp.json()
        actual_mode = data["config"]["services"]["dynamodb"]["mode"]
        assert actual_mode == expected_mode

    def test_post_registers_identity_via_identities_key(self, client_with_bundle):
        # Arrange
        expected_status_code = 200
        identity_payload = {
            "identities": {
                "test-user": {
                    "inline_policies": [
                        {
                            "Version": "2012-10-17",
                            "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}],
                        }
                    ]
                }
            }
        }

        # Act
        resp = client_with_bundle.post("/_ldk/iam-auth", json=identity_payload)

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_post_registers_identity_retrievable_from_store(self):
        # Arrange
        orchestrator = Orchestrator()
        bundle = _make_bundle(mode="disabled")
        router = create_management_router(
            orchestrator=orchestrator,
            iam_auth_bundle=bundle,
        )
        fast_app = FastAPI()
        fast_app.include_router(router)
        client = TestClient(fast_app)
        expected_name = "registered-user"
        identity_payload = {
            "identities": {
                expected_name: {"inline_policies": [{"Version": "2012-10-17", "Statement": []}]}
            }
        }

        # Act
        client.post("/_ldk/iam-auth", json=identity_payload)

        # Assert
        actual_identity = bundle.identity_store.get_identity(expected_name)
        assert actual_identity is not None
        actual_policies = actual_identity.inline_policies
        assert actual_policies == [{"Version": "2012-10-17", "Statement": []}]
