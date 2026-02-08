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


class TestFnGetAtt:
    """Fn::GetAtt intrinsic function resolution."""

    def test_get_att_resolves_from_registry(self) -> None:
        env = {"TABLE_ARN": {"Fn::GetAtt": ["MyTable", "Arn"]}}
        registry = {"MyTable.Arn": "arn:aws:dynamodb:us-east-1:000:table/T"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["TABLE_ARN"] == "arn:aws:dynamodb:us-east-1:000:table/T"

    def test_get_att_unresolvable_uses_composite_key(self) -> None:
        env = {"TABLE_ARN": {"Fn::GetAtt": ["UnknownTable", "Arn"]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["TABLE_ARN"] == "UnknownTable.Arn"
