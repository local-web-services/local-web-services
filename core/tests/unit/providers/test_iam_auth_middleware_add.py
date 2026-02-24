"""Unit tests for add_iam_auth_middleware helper."""

from __future__ import annotations

from fastapi import FastAPI

from lws.config.loader import IamAuthConfig, IamAuthServiceConfig
from lws.providers._shared.aws_chaos import ErrorFormat
from lws.providers._shared.aws_iam_auth import (
    IamAuthBundle,
    add_iam_auth_middleware,
)
from lws.providers._shared.iam_identity_store import IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore


class TestAddIamAuthMiddleware:
    def test_adds_middleware_when_enabled(self):
        # Arrange
        config = IamAuthConfig(
            mode="enforce",
            services={"dynamodb": IamAuthServiceConfig(enabled=True)},
        )
        bundle = IamAuthBundle(
            config=config,
            identity_store=IdentityStore(),
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )
        app = FastAPI()

        # Act
        add_iam_auth_middleware(app, "dynamodb", bundle, ErrorFormat.JSON)

        # Assert
        assert len(app.user_middleware) == 1

    def test_does_not_add_when_none(self):
        # Arrange
        app = FastAPI()

        # Act
        add_iam_auth_middleware(app, "dynamodb", None, ErrorFormat.JSON)

        # Assert
        assert len(app.user_middleware) == 0

    def test_adds_middleware_even_when_service_has_enabled_false(self):
        # Arrange
        # enabled=False on a service config no longer prevents middleware from being added;
        # the middleware's dispatch method handles mode checks at request time.
        config = IamAuthConfig(
            mode="enforce",
            services={"dynamodb": IamAuthServiceConfig(enabled=False)},
        )
        bundle = IamAuthBundle(
            config=config,
            identity_store=IdentityStore(),
            permissions_map=PermissionsMap(),
            resource_policy_store=ResourcePolicyStore(),
        )
        app = FastAPI()

        # Act
        add_iam_auth_middleware(app, "dynamodb", bundle, ErrorFormat.JSON)

        # Assert
        expected_middleware_count = 1
        actual_middleware_count = len(app.user_middleware)
        assert actual_middleware_count == expected_middleware_count
