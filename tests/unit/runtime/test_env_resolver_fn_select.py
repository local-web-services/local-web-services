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
        env = {"AZ": {"Fn::Select": [1, ["us-east-1a", "us-east-1b", "us-east-1c"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["AZ"] == "us-east-1b"

    def test_select_first_element(self) -> None:
        env = {"FIRST": {"Fn::Select": [0, ["alpha", "beta", "gamma"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["FIRST"] == "alpha"

    def test_select_with_nested_ref(self) -> None:
        env = {"CHOICE": {"Fn::Select": [0, [{"Ref": "MyResource"}, "fallback"]]}}
        registry = {"MyResource": "resolved-value"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["CHOICE"] == "resolved-value"
