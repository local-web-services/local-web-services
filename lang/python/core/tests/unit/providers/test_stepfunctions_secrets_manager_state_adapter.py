"""Tests for SecretsManagerStateAdapter — in-process GetSecretValue bridge."""

from __future__ import annotations

import time
import uuid

import pytest

from lws.providers.secretsmanager._secretsmanager_state import (
    _Secret,
    _SecretsState,
    _SecretVersion,
)
from lws.providers.stepfunctions._service_task_bridge import SecretsManagerStateAdapter

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_state_with_secret(
    name: str = "my-secret",
    secret_string: str = "s3cr3t",
) -> _SecretsState:
    """Return a _SecretsState pre-populated with a single secret at AWSCURRENT."""
    state = _SecretsState()
    secret = _Secret(name=name)
    version = _SecretVersion(
        version_id=str(uuid.uuid4()),
        secret_string=secret_string,
        stages=["AWSCURRENT"],
    )
    secret.versions[version.version_id] = version
    secret.current_version_id = version.version_id
    state.secrets[name] = secret
    return state


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


class TestSecretsManagerStateAdapterGetSecretValue:
    """SecretsManagerStateAdapter.get_secret_value() returns correct shapes."""

    def test_get_secret_value_returns_name(self) -> None:
        # Arrange
        expected_name = "prod/db/password"
        state = _make_state_with_secret(name=expected_name)
        adapter = SecretsManagerStateAdapter(state)

        # Act
        result = adapter.get_secret_value(expected_name)

        # Assert
        actual_name = result["Name"]
        assert actual_name == expected_name

    def test_get_secret_value_returns_secret_string(self) -> None:
        # Arrange
        expected_secret = '{"username": "admin", "password": "hunter2"}'
        state = _make_state_with_secret(name="db-creds", secret_string=expected_secret)
        adapter = SecretsManagerStateAdapter(state)

        # Act
        result = adapter.get_secret_value("db-creds")

        # Assert
        actual_secret = result["SecretString"]
        assert actual_secret == expected_secret

    def test_get_secret_value_returns_arn(self) -> None:
        # Arrange
        state = _make_state_with_secret(name="arn-test-secret")
        adapter = SecretsManagerStateAdapter(state)

        # Act
        result = adapter.get_secret_value("arn-test-secret")

        # Assert
        actual_arn = result["ARN"]
        assert "arn:aws:secretsmanager" in actual_arn
        assert "arn-test-secret" in actual_arn

    def test_get_secret_value_returns_version_id(self) -> None:
        # Arrange
        state = _make_state_with_secret(name="versioned-secret")
        adapter = SecretsManagerStateAdapter(state)

        # Act
        result = adapter.get_secret_value("versioned-secret")

        # Assert
        actual_version_id = result["VersionId"]
        assert actual_version_id is not None
        assert len(actual_version_id) > 0

    def test_get_secret_value_by_arn(self) -> None:
        # Arrange
        expected_name = "arn-lookup-secret"
        state = _make_state_with_secret(name=expected_name)
        adapter = SecretsManagerStateAdapter(state)
        secret_arn = state.secrets[expected_name].arn

        # Act
        result = adapter.get_secret_value(secret_arn)

        # Assert
        actual_name = result["Name"]
        assert actual_name == expected_name

    def test_get_secret_value_not_found_raises_key_error(self) -> None:
        # Arrange
        state = _SecretsState()
        adapter = SecretsManagerStateAdapter(state)
        expected_error_pattern = "Secret not found"

        # Act
        # Assert
        with pytest.raises(KeyError, match=expected_error_pattern):
            adapter.get_secret_value("nonexistent-secret")

    def test_get_secret_value_deleted_secret_raises_key_error(self) -> None:
        # Arrange
        expected_name = "deleted-secret"
        state = _make_state_with_secret(name=expected_name)
        state.secrets[expected_name].deleted_date = time.time()
        adapter = SecretsManagerStateAdapter(state)
        expected_error_pattern = "Secret not found"

        # Act
        # Assert
        with pytest.raises(KeyError, match=expected_error_pattern):
            adapter.get_secret_value(expected_name)

    def test_get_secret_value_no_current_version_raises(self) -> None:
        # Arrange
        state = _SecretsState()
        secret = _Secret(name="no-version-secret")
        state.secrets["no-version-secret"] = secret
        adapter = SecretsManagerStateAdapter(state)
        expected_error_pattern = "No current version"

        # Act
        # Assert
        with pytest.raises(KeyError, match=expected_error_pattern):
            adapter.get_secret_value("no-version-secret")

    def test_get_secret_value_response_has_version_stages(self) -> None:
        # Arrange
        state = _make_state_with_secret(name="stages-secret")
        adapter = SecretsManagerStateAdapter(state)

        # Act
        result = adapter.get_secret_value("stages-secret")

        # Assert
        actual_stages = result["VersionStages"]
        assert "AWSCURRENT" in actual_stages
