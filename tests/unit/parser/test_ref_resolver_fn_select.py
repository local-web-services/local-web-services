"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

import logging

from lws.parser.ref_resolver import RefResolver


class TestFnSelect:
    def test_select_basic(self):
        # Arrange
        expected_value = "b"

        # Act
        r = RefResolver()
        actual_value = r.resolve({"Fn::Select": [1, ["a", "b", "c"]]})

        # Assert
        assert actual_value == expected_value

    def test_select_zero_index(self):
        # Arrange
        expected_value = "first"

        # Act
        r = RefResolver()
        actual_value = r.resolve({"Fn::Select": [0, ["first", "second"]]})

        # Assert
        assert actual_value == expected_value

    def test_select_out_of_range(self, caplog):
        # Arrange
        expected_value = ""

        # Act
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            actual_value = r.resolve({"Fn::Select": [5, ["a"]]})

        # Assert
        assert actual_value == expected_value
        assert "out of range" in caplog.text
