"""Tests for SsmStateAdapter — in-process SSM GetParameter bridge."""

from __future__ import annotations

import pytest

from lws.providers.ssm._ssm_state import _Parameter, _SsmState
from lws.providers.stepfunctions._service_task_bridge import SsmStateAdapter


def _make_state_with_parameter(
    name: str = "/app/key",
    value: str = "my-value",
    param_type: str = "String",
) -> _SsmState:
    """Return an _SsmState pre-populated with a single parameter."""
    state = _SsmState()
    param = _Parameter(name=name, value=value, param_type=param_type)
    state.parameters[name] = param
    return state


class TestSsmStateAdapterGetParameter:
    """SsmStateAdapter.get_parameter() returns correct response shapes."""

    def test_get_parameter_returns_name(self) -> None:
        # Arrange
        expected_name = "/service/db/host"
        state = _make_state_with_parameter(name=expected_name, value="localhost")
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter(expected_name)

        # Assert
        actual_name = result["Parameter"]["Name"]
        assert actual_name == expected_name

    def test_get_parameter_returns_value(self) -> None:
        # Arrange
        expected_value = "prod-db-hostname"
        state = _make_state_with_parameter(name="/db/host", value=expected_value)
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter("/db/host")

        # Assert
        actual_value = result["Parameter"]["Value"]
        assert actual_value == expected_value

    def test_get_parameter_returns_type(self) -> None:
        # Arrange
        expected_type = "SecureString"
        state = _make_state_with_parameter(name="/secrets/token", param_type=expected_type)
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter("/secrets/token")

        # Assert
        actual_type = result["Parameter"]["Type"]
        assert actual_type == expected_type

    def test_get_parameter_returns_version(self) -> None:
        # Arrange
        expected_version = 1
        state = _make_state_with_parameter(name="/app/ver")
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter("/app/ver")

        # Assert
        actual_version = result["Parameter"]["Version"]
        assert actual_version == expected_version

    def test_get_parameter_returns_arn(self) -> None:
        # Arrange
        state = _make_state_with_parameter(name="/app/arn-test")
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter("/app/arn-test")

        # Assert
        actual_arn = result["Parameter"]["ARN"]
        assert "arn:aws:ssm" in actual_arn
        assert "arn-test" in actual_arn

    def test_get_parameter_not_found_raises_key_error(self) -> None:
        # Arrange
        state = _SsmState()
        adapter = SsmStateAdapter(state)
        expected_error_pattern = "Parameter not found"

        # Act
        # Assert
        with pytest.raises(KeyError, match=expected_error_pattern):
            adapter.get_parameter("/nonexistent/key")

    def test_get_parameter_response_has_parameter_key(self) -> None:
        # Arrange
        state = _make_state_with_parameter(name="/app/shape")
        adapter = SsmStateAdapter(state)

        # Act
        result = adapter.get_parameter("/app/shape")

        # Assert
        assert "Parameter" in result
