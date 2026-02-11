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


class TestFnGetAtt:
    """Fn::GetAtt intrinsic function resolution."""

    def test_get_att_resolves_from_registry(self) -> None:
        # Arrange
        expected_arn = "arn:aws:dynamodb:us-east-1:000:table/T"
        env = {"TABLE_ARN": {"Fn::GetAtt": ["MyTable", "Arn"]}}
        registry = {"MyTable.Arn": expected_arn}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_arn = result["TABLE_ARN"]
        assert actual_arn == expected_arn

    def test_get_att_unresolvable_uses_composite_key(self) -> None:
        # Arrange
        expected_arn = "UnknownTable.Arn"
        env = {"TABLE_ARN": {"Fn::GetAtt": ["UnknownTable", "Arn"]}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_arn = result["TABLE_ARN"]
        assert actual_arn == expected_arn
