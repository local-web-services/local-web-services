"""Tests for LambdaRegistry tag methods."""

from __future__ import annotations

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
)

_FUNC_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"


class TestLambdaRegistryTagMethods:
    """Unit tests for the LambdaRegistry tag methods directly."""

    def test_tag_resource(self) -> None:
        registry = LambdaRegistry()
        registry.tag_resource("arn:test", {"env": "prod"})
        assert registry.get_tags("arn:test") == {"env": "prod"}

    def test_tag_resource_merges(self) -> None:
        registry = LambdaRegistry()
        registry.tag_resource("arn:test", {"env": "prod"})
        registry.tag_resource("arn:test", {"team": "backend"})
        assert registry.get_tags("arn:test") == {"env": "prod", "team": "backend"}

    def test_untag_resource(self) -> None:
        registry = LambdaRegistry()
        registry.tag_resource("arn:test", {"env": "prod", "team": "backend"})
        registry.untag_resource("arn:test", ["env"])
        assert registry.get_tags("arn:test") == {"team": "backend"}

    def test_untag_nonexistent_arn_is_noop(self) -> None:
        registry = LambdaRegistry()
        registry.untag_resource("arn:nonexistent", ["env"])
        assert registry.get_tags("arn:nonexistent") == {}

    def test_get_tags_returns_copy(self) -> None:
        registry = LambdaRegistry()
        registry.tag_resource("arn:test", {"env": "prod"})
        tags = registry.get_tags("arn:test")
        tags["extra"] = "should_not_persist"
        assert "extra" not in registry.get_tags("arn:test")

    def test_update_config(self) -> None:
        registry = LambdaRegistry()
        registry.register("func", {"FunctionName": "func", "Timeout": 3}, None)
        result = registry.update_config("func", {"Timeout": 30})
        assert result is not None
        assert result["Timeout"] == 30

    def test_update_config_nonexistent(self) -> None:
        registry = LambdaRegistry()
        result = registry.update_config("nonexistent", {"Timeout": 30})
        assert result is None
