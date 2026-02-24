"""Unit tests for IamAuthConfig dataclass."""

from __future__ import annotations

from lws.config.loader import IamAuthConfig, IamAuthServiceConfig


class TestIamAuthConfig:
    def test_defaults(self):
        # Arrange
        config = IamAuthConfig()

        # Act
        actual_mode = config.mode
        actual_default_identity = config.default_identity
        actual_identity_header = config.identity_header
        actual_services = config.services

        # Assert
        expected_mode = "disabled"
        expected_default_identity = "admin-user"
        expected_identity_header = "X-Lws-Identity"
        assert actual_mode == expected_mode
        assert actual_default_identity == expected_default_identity
        assert actual_identity_header == expected_identity_header
        assert actual_services == {}

    def test_custom_values(self):
        # Arrange
        expected_mode = "enforce"
        expected_identity = "test-user"
        config = IamAuthConfig(
            mode=expected_mode,
            default_identity=expected_identity,
            services={
                "dynamodb": IamAuthServiceConfig(enabled=True, mode="audit"),
            },
        )

        # Act
        actual_mode = config.mode
        actual_identity = config.default_identity
        actual_dynamo = config.services["dynamodb"]

        # Assert
        assert actual_mode == expected_mode
        assert actual_identity == expected_identity
        assert actual_dynamo.enabled is True
        expected_dynamo_mode = "audit"
        assert actual_dynamo.mode == expected_dynamo_mode
