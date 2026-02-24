"""Tests for ldk.runtime.env_resolver (P1-05)."""

from __future__ import annotations

from lws.runtime.env_resolver import resolve_env_vars

# ---------------------------------------------------------------------------
# Plain string passthrough
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Ref resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::GetAtt resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Join resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Sub resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Select resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Mixed / integration
# ---------------------------------------------------------------------------


class TestFnSelect:
    """Fn::Select intrinsic function resolution."""

    def test_select_by_index(self) -> None:
        # Arrange
        expected_az = "us-east-1b"
        env = {"AZ": {"Fn::Select": [1, ["us-east-1a", expected_az, "us-east-1c"]]}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_az = result["AZ"]
        assert actual_az == expected_az

    def test_select_first_element(self) -> None:
        # Arrange
        expected_first = "alpha"
        env = {"FIRST": {"Fn::Select": [0, [expected_first, "beta", "gamma"]]}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_first = result["FIRST"]
        assert actual_first == expected_first

    def test_select_with_nested_ref(self) -> None:
        # Arrange
        expected_choice = "resolved-value"
        env = {"CHOICE": {"Fn::Select": [0, [{"Ref": "MyResource"}, "fallback"]]}}
        registry = {"MyResource": expected_choice}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_choice = result["CHOICE"]
        assert actual_choice == expected_choice
