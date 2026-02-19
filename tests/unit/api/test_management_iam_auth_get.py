"""Unit tests for the IAM auth GET management endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.config.loader import IamAuthConfig, IamAuthServiceConfig
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
    bundle = _make_bundle(mode="audit")
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


class TestManagementIamAuthGet:
    """Tests for GET /_ldk/iam-auth."""

    def test_get_returns_200_when_bundle_present(self, client_with_bundle):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client_with_bundle.get("/_ldk/iam-auth")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_get_returns_mode_when_bundle_present(self, client_with_bundle):
        # Arrange
        expected_mode = "audit"

        # Act
        resp = client_with_bundle.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_mode = data["mode"]
        assert actual_mode == expected_mode

    def test_get_returns_default_identity_when_bundle_present(self, client_with_bundle):
        # Arrange
        expected_default_identity = "admin-user"

        # Act
        resp = client_with_bundle.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_default_identity = data["default_identity"]
        assert actual_default_identity == expected_default_identity

    def test_get_returns_services_when_bundle_present(self, client_with_bundle):
        # Arrange
        expected_services = {}

        # Act
        resp = client_with_bundle.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_services = data["services"]
        assert actual_services == expected_services

    def test_get_returns_enabled_false_when_no_bundle(self, client_without_bundle):
        # Arrange
        expected_enabled = False

        # Act
        resp = client_without_bundle.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_enabled = data["enabled"]
        assert actual_enabled == expected_enabled

    def test_get_returns_200_when_no_bundle(self, client_without_bundle):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client_without_bundle.get("/_ldk/iam-auth")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_get_returns_identity_header_when_bundle_present(self, client_with_bundle):
        # Arrange
        expected_identity_header = "X-Lws-Identity"

        # Act
        resp = client_with_bundle.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_identity_header = data["identity_header"]
        assert actual_identity_header == expected_identity_header

    def test_get_returns_service_config_when_services_present(self):
        # Arrange
        expected_mode = "enforce"
        config = IamAuthConfig(
            mode="disabled",
            services={"dynamodb": IamAuthServiceConfig(mode="enforce", enabled=True)},
        )
        bundle = IamAuthBundle(
            config=config,
            identity_store=IdentityStore(None),
            permissions_map=PermissionsMap(None),
            resource_policy_store=ResourcePolicyStore(None),
        )
        orchestrator = Orchestrator()
        router = create_management_router(orchestrator=orchestrator, iam_auth_bundle=bundle)
        fast_app = FastAPI()
        fast_app.include_router(router)
        client = TestClient(fast_app)

        # Act
        resp = client.get("/_ldk/iam-auth")

        # Assert
        data = resp.json()
        actual_mode = data["services"]["dynamodb"]["mode"]
        assert actual_mode == expected_mode
