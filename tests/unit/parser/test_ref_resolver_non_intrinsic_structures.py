"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestNonIntrinsicStructures:
    def test_plain_string_passthrough(self):
        r = RefResolver()
        assert r.resolve("hello") == "hello"

    def test_plain_int_passthrough(self):
        r = RefResolver()
        assert r.resolve(42) == 42

    def test_plain_dict_values_resolved(self):
        r = RefResolver(resource_map={"X": "val"})
        result = r.resolve({"Key": {"Ref": "X"}, "Other": "literal"})
        assert result == {"Key": "val", "Other": "literal"}

    def test_list_elements_resolved(self):
        r = RefResolver(resource_map={"A": "a_val"})
        result = r.resolve([{"Ref": "A"}, "plain"])
        assert result == ["a_val", "plain"]
