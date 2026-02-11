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


class TestRef:
    """Ref intrinsic function resolution."""

    def test_ref_resolves_from_registry(self) -> None:
        # Arrange
        expected_table_name = "local-my-table"
        env = {"TABLE_NAME": {"Ref": "MyTable"}}
        registry = {"MyTable": expected_table_name}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_table_name = result["TABLE_NAME"]
        assert actual_table_name == expected_table_name

    def test_ref_unresolvable_uses_logical_id(self) -> None:
        # Arrange
        expected_table_name = "UnknownResource"
        env = {"TABLE_NAME": {"Ref": expected_table_name}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_table_name = result["TABLE_NAME"]
        assert actual_table_name == expected_table_name
