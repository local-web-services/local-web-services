"""Tests for SecretsManager RotateSecret handler."""

from __future__ import annotations

from lws.providers.secretsmanager._secretsmanager_handlers import _handle_rotate_secret
from lws.providers.secretsmanager._secretsmanager_state import (
    _Secret,
    _SecretsState,
    _SecretVersion,
)

from ._helpers import FakeRotationCompute, FakeRotationRegistry


class TestSecretsManagerRotateSecret:
    """Tests for the RotateSecret Lambda rotation flow."""

    def _make_state_with_secret(self, name: str) -> tuple[_SecretsState, _Secret]:
        state = _SecretsState()
        secret = _Secret(name=name)
        version = _SecretVersion(version_id="v1", secret_string="initial")
        secret.versions["v1"] = version
        secret.current_version_id = "v1"
        state.secrets[name] = secret
        return state, secret

    async def test_rotate_secret_invokes_lambda_four_phases(self) -> None:
        # Arrange
        state, _ = self._make_state_with_secret("my-secret")
        compute = FakeRotationCompute()
        registry = FakeRotationRegistry(compute)
        body = {
            "SecretId": "my-secret",
            "RotationLambdaARN": ("arn:aws:lambda:us-east-1:000000000000:function:rotation-fn"),
        }
        expected_phase_count = 4

        # Act
        resp = await _handle_rotate_secret(state, body, registry)

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_phase_count = len(compute.invocations)
        assert (
            actual_phase_count == expected_phase_count
        ), f"Expected {expected_phase_count!r} but got {actual_phase_count!r}"

    async def test_rotate_secret_phases_in_correct_order(self) -> None:
        # Arrange
        state, _ = self._make_state_with_secret("phase-order-secret")
        compute = FakeRotationCompute()
        registry = FakeRotationRegistry(compute)
        body = {
            "SecretId": "phase-order-secret",
            "RotationLambdaARN": ("arn:aws:lambda:us-east-1:000000000000:function:rotation-fn"),
        }
        expected_phases = ["createSecret", "setSecret", "testSecret", "finishSecret"]

        # Act
        await _handle_rotate_secret(state, body, registry)

        # Assert
        actual_phases = [inv["Step"] for inv in compute.invocations]
        assert (
            actual_phases == expected_phases
        ), f"Expected {expected_phases!r} but got {actual_phases!r}"

    async def test_rotate_secret_promotes_pending_to_current(self) -> None:
        # Arrange
        state, secret = self._make_state_with_secret("promote-secret")
        compute = FakeRotationCompute()
        registry = FakeRotationRegistry(compute)
        body = {
            "SecretId": "promote-secret",
            "RotationLambdaARN": ("arn:aws:lambda:us-east-1:000000000000:function:rotation-fn"),
        }
        expected_stage = "AWSCURRENT"

        # Act
        await _handle_rotate_secret(state, body, registry)

        # Assert
        new_version_id = secret.current_version_id
        assert new_version_id != "v1", "Expected current version to change after rotation"
        actual_stages = secret.versions[new_version_id].stages
        assert expected_stage in actual_stages, f"Expected {expected_stage!r} in {actual_stages!r}"

    async def test_rotate_secret_no_registry_returns_error(self) -> None:
        # Arrange
        state, _ = self._make_state_with_secret("no-lambda-secret")
        body = {
            "SecretId": "no-lambda-secret",
            "RotationLambdaARN": ("arn:aws:lambda:us-east-1:000000000000:function:rotation-fn"),
        }
        expected_status = 400

        # Act
        resp = await _handle_rotate_secret(state, body, None)

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    async def test_rotate_secret_missing_secret_returns_error(self) -> None:
        # Arrange
        state = _SecretsState()
        body = {
            "SecretId": "nonexistent",
            "RotationLambdaARN": "arn:aws:lambda:us-east-1:000000000000:function:fn",
        }
        expected_status = 400

        # Act
        resp = await _handle_rotate_secret(state, body)

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
