"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnJoin:
    def test_join_basic(self):
        r = RefResolver()
        result = r.resolve({"Fn::Join": ["-", ["a", "b", "c"]]})
        assert result == "a-b-c"

    def test_join_with_refs(self):
        r = RefResolver(resource_map={"X": "hello"})
        result = r.resolve({"Fn::Join": ["/", ["prefix", {"Ref": "X"}, "suffix"]]})
        assert result == "prefix/hello/suffix"

    def test_join_empty_delimiter(self):
        r = RefResolver()
        result = r.resolve({"Fn::Join": ["", ["abc", "def"]]})
        assert result == "abcdef"
