"""Tests for ldk.runtime.env_resolver (P1-05)."""

from __future__ import annotations

from ldk.runtime.env_resolver import resolve_env_vars

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
        env = {"TABLE_NAME": {"Ref": "MyTable"}}
        registry = {"MyTable": "local-my-table"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["TABLE_NAME"] == "local-my-table"

    def test_ref_unresolvable_uses_logical_id(self) -> None:
        env = {"TABLE_NAME": {"Ref": "UnknownResource"}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["TABLE_NAME"] == "UnknownResource"
