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


class TestFnJoin:
    """Fn::Join intrinsic function resolution."""

    def test_join_with_delimiter(self) -> None:
        # Arrange
        expected_url = "hello-world"
        env = {"URL": {"Fn::Join": ["-", ["hello", "world"]]}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_url = result["URL"]
        assert actual_url == expected_url

    def test_join_with_empty_delimiter(self) -> None:
        # Arrange
        expected_url = "https://example.com"
        env = {"URL": {"Fn::Join": ["", ["https://", "example", ".com"]]}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_url = result["URL"]
        assert actual_url == expected_url

    def test_join_resolves_nested_refs(self) -> None:
        # Arrange
        expected_endpoint = "https://api.example.com/prod"
        env = {
            "ENDPOINT": {
                "Fn::Join": [
                    "/",
                    ["https://api.example.com", {"Ref": "ApiStage"}],
                ]
            }
        }
        registry = {"ApiStage": "prod"}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_endpoint = result["ENDPOINT"]
        assert actual_endpoint == expected_endpoint
