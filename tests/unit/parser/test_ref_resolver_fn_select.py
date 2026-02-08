"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

import logging

from ldk.parser.ref_resolver import RefResolver


class TestFnSelect:
    def test_select_basic(self):
        r = RefResolver()
        result = r.resolve({"Fn::Select": [1, ["a", "b", "c"]]})
        assert result == "b"

    def test_select_zero_index(self):
        r = RefResolver()
        result = r.resolve({"Fn::Select": [0, ["first", "second"]]})
        assert result == "first"

    def test_select_out_of_range(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            result = r.resolve({"Fn::Select": [5, ["a"]]})
        assert result == ""
        assert "out of range" in caplog.text
