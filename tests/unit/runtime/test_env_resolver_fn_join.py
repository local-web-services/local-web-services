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


class TestFnJoin:
    """Fn::Join intrinsic function resolution."""

    def test_join_with_delimiter(self) -> None:
        env = {"URL": {"Fn::Join": ["-", ["hello", "world"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["URL"] == "hello-world"

    def test_join_with_empty_delimiter(self) -> None:
        env = {"URL": {"Fn::Join": ["", ["https://", "example", ".com"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["URL"] == "https://example.com"

    def test_join_resolves_nested_refs(self) -> None:
        env = {
            "ENDPOINT": {
                "Fn::Join": [
                    "/",
                    ["https://api.example.com", {"Ref": "ApiStage"}],
                ]
            }
        }
        registry = {"ApiStage": "prod"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["ENDPOINT"] == "https://api.example.com/prod"
