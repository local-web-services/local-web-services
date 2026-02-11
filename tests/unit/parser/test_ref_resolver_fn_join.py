"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnJoin:
    def test_join_basic(self):
        # Arrange
        expected_value = "a-b-c"

        # Act
        r = RefResolver()
        actual_value = r.resolve({"Fn::Join": ["-", ["a", "b", "c"]]})

        # Assert
        assert actual_value == expected_value

    def test_join_with_refs(self):
        # Arrange
        expected_value = "prefix/hello/suffix"
        r = RefResolver(resource_map={"X": "hello"})

        # Act
        actual_value = r.resolve({"Fn::Join": ["/", ["prefix", {"Ref": "X"}, "suffix"]]})

        # Assert
        assert actual_value == expected_value

    def test_join_empty_delimiter(self):
        # Arrange
        expected_value = "abcdef"

        # Act
        r = RefResolver()
        actual_value = r.resolve({"Fn::Join": ["", ["abc", "def"]]})

        # Assert
        assert actual_value == expected_value
