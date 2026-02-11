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


class TestPassthrough:
    """Plain string values are passed through unchanged."""

    def test_plain_strings_unchanged(self) -> None:
        # Arrange
        expected_env = {"MY_VAR": "hello", "OTHER": "world"}

        # Act
        actual_env = resolve_env_vars(expected_env, resource_registry={})

        # Assert
        assert actual_env == expected_env

    def test_empty_env(self) -> None:
        # Act
        actual_env = resolve_env_vars({}, resource_registry={})

        # Assert
        assert actual_env == {}
