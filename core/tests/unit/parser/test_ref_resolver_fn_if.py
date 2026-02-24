"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnIf:
    def test_if_true(self):
        # Arrange
        expected_value = "prod-value"
        r = RefResolver(conditions={"IsProd": True})

        # Act
        actual_value = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})

        # Assert
        assert actual_value == expected_value

    def test_if_false(self):
        # Arrange
        expected_value = "dev-value"
        r = RefResolver(conditions={"IsProd": False})

        # Act
        actual_value = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})

        # Assert
        assert actual_value == expected_value

    def test_if_unknown_condition_defaults_true(self):
        # Arrange
        expected_value = "yes"
        r = RefResolver()

        # Act
        actual_value = r.resolve({"Fn::If": ["UnknownCond", "yes", "no"]})

        # Assert
        assert actual_value == expected_value

    def test_if_with_nested_intrinsics(self):
        # Arrange
        expected_value = "custom-val"
        r = RefResolver(
            conditions={"UseCustom": True},
            resource_map={"Custom": expected_value},
        )

        # Act
        actual_value = r.resolve({"Fn::If": ["UseCustom", {"Ref": "Custom"}, "default"]})

        # Assert
        assert actual_value == expected_value
