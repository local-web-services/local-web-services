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
        # Arrange
        expected_plain = "just-a-string"
        expected_table = "local-table"
        expected_arn = "arn:aws:dynamodb:us-east-1:000:table/local-table"
        expected_joined = "a,b,c"
        expected_subbed = "prefix-local-table"
        expected_selected = "z"

        env = {
            "PLAIN": expected_plain,
            "TABLE": {"Ref": "MyTable"},
            "ARN": {"Fn::GetAtt": ["MyTable", "Arn"]},
            "JOINED": {"Fn::Join": [",", ["a", "b", "c"]]},
            "SUBBED": {"Fn::Sub": "prefix-${MyTable}"},
            "SELECTED": {"Fn::Select": [2, ["x", "y", expected_selected]]},
        }
        registry = {
            "MyTable": expected_table,
            "MyTable.Arn": expected_arn,
        }

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        assert result["PLAIN"] == expected_plain
        assert result["TABLE"] == expected_table
        assert result["ARN"] == expected_arn
        assert result["JOINED"] == expected_joined
        assert result["SUBBED"] == expected_subbed
        assert result["SELECTED"] == expected_selected
