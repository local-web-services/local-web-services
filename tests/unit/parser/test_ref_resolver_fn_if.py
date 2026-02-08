"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from ldk.parser.ref_resolver import RefResolver


class TestFnIf:
    def test_if_true(self):
        r = RefResolver(conditions={"IsProd": True})
        result = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})
        assert result == "prod-value"

    def test_if_false(self):
        r = RefResolver(conditions={"IsProd": False})
        result = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})
        assert result == "dev-value"

    def test_if_unknown_condition_defaults_true(self):
        r = RefResolver()
        result = r.resolve({"Fn::If": ["UnknownCond", "yes", "no"]})
        assert result == "yes"

    def test_if_with_nested_intrinsics(self):
        r = RefResolver(
            conditions={"UseCustom": True},
            resource_map={"Custom": "custom-val"},
        )
        result = r.resolve({"Fn::If": ["UseCustom", {"Ref": "Custom"}, "default"]})
        assert result == "custom-val"
