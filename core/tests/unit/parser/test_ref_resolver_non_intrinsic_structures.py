"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestNonIntrinsicStructures:
    def test_plain_string_passthrough(self):
        # Arrange
        expected_value = "hello"

        # Act
        r = RefResolver()
        actual_value = r.resolve("hello")

        # Assert
        assert actual_value == expected_value

    def test_plain_int_passthrough(self):
        # Arrange
        expected_value = 42

        # Act
        r = RefResolver()
        actual_value = r.resolve(42)

        # Assert
        assert actual_value == expected_value

    def test_plain_dict_values_resolved(self):
        # Arrange
        expected_value = {"Key": "val", "Other": "literal"}
        r = RefResolver(resource_map={"X": "val"})

        # Act
        actual_value = r.resolve({"Key": {"Ref": "X"}, "Other": "literal"})

        # Assert
        assert actual_value == expected_value

    def test_list_elements_resolved(self):
        # Arrange
        expected_value = ["a_val", "plain"]
        r = RefResolver(resource_map={"A": "a_val"})

        # Act
        actual_value = r.resolve([{"Ref": "A"}, "plain"])

        # Assert
        assert actual_value == expected_value
