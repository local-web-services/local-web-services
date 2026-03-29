"""Tests for Cognito pre-signup Lambda trigger."""

from __future__ import annotations

import pytest

from lws.providers.cognito._cognito_auth import PasswordPolicy, UserPoolConfig
from lws.providers.cognito.provider import CognitoProvider


class TestCognitoPreSignupTrigger:
    """Tests for the pre-signup Lambda trigger invocation."""

    @pytest.fixture
    def data_dir(self, tmp_path):
        """Return a temporary directory for the user store."""
        return tmp_path

    @pytest.fixture
    def pool_config_with_trigger(self) -> UserPoolConfig:
        """Return a pool config with a pre-signup trigger."""
        return UserPoolConfig(
            user_pool_id="us-east-1_test123",
            user_pool_name="test-pool",
            password_policy=PasswordPolicy(minimum_length=6, require_symbols=False),
            auto_confirm=False,
            pre_signup_trigger="pre-signup-fn",
        )

    async def test_pre_signup_trigger_invoked_on_sign_up(
        self, data_dir, pool_config_with_trigger
    ) -> None:
        # Arrange
        invocation_log: list[dict] = []

        async def mock_trigger(event: dict) -> dict:
            invocation_log.append(event)
            return event

        provider = CognitoProvider(
            data_dir=data_dir,
            config=pool_config_with_trigger,
            trigger_functions={"pre-signup-fn": mock_trigger},
        )
        await provider.start()
        expected_invocation_count = 1

        # Act
        await provider.sign_up("testuser", "TestPass1!", {"email": "test@example.com"})

        # Assert
        actual_invocation_count = len(invocation_log)
        assert (
            actual_invocation_count == expected_invocation_count
        ), f"Expected {expected_invocation_count!r} but got {actual_invocation_count!r}"
        actual_trigger_source = invocation_log[0]["triggerSource"]
        expected_trigger_source = "PreSignUp_SignUp"
        assert (
            actual_trigger_source == expected_trigger_source
        ), f"Expected {expected_trigger_source!r} but got {actual_trigger_source!r}"

    async def test_pre_signup_trigger_not_invoked_when_not_configured(self, data_dir) -> None:
        # Arrange
        invocation_log: list[dict] = []

        async def mock_trigger(event: dict) -> dict:
            invocation_log.append(event)
            return event

        config = UserPoolConfig(
            user_pool_id="us-east-1_test456",
            password_policy=PasswordPolicy(minimum_length=6, require_symbols=False),
            auto_confirm=False,
        )
        provider = CognitoProvider(
            data_dir=data_dir,
            config=config,
            trigger_functions={"other-fn": mock_trigger},
        )
        await provider.start()
        expected_invocation_count = 0

        # Act
        await provider.sign_up("testuser2", "TestPass1!")

        # Assert
        actual_invocation_count = len(invocation_log)
        assert (
            actual_invocation_count == expected_invocation_count
        ), f"Expected {expected_invocation_count!r} but got {actual_invocation_count!r}"
