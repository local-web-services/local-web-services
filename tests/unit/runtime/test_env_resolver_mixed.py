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


class TestMixed:
    """Combined scenarios with multiple intrinsic types."""

    def test_mixed_env_with_multiple_types(self) -> None:
        env = {
            "PLAIN": "just-a-string",
            "TABLE": {"Ref": "MyTable"},
            "ARN": {"Fn::GetAtt": ["MyTable", "Arn"]},
            "JOINED": {"Fn::Join": [",", ["a", "b", "c"]]},
            "SUBBED": {"Fn::Sub": "prefix-${MyTable}"},
            "SELECTED": {"Fn::Select": [2, ["x", "y", "z"]]},
        }
        registry = {
            "MyTable": "local-table",
            "MyTable.Arn": "arn:aws:dynamodb:us-east-1:000:table/local-table",
        }
        result = resolve_env_vars(env, resource_registry=registry)

        assert result["PLAIN"] == "just-a-string"
        assert result["TABLE"] == "local-table"
        assert result["ARN"] == "arn:aws:dynamodb:us-east-1:000:table/local-table"
        assert result["JOINED"] == "a,b,c"
        assert result["SUBBED"] == "prefix-local-table"
        assert result["SELECTED"] == "z"
