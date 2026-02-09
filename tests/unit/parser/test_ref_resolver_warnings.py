"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

import logging

from lws.parser.ref_resolver import RefResolver


class TestWarnings:
    def test_unresolvable_get_att_warns(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            r.resolve({"Fn::GetAtt": 42})
        assert "Unresolvable Fn::GetAtt" in caplog.text

    def test_bad_join_warns(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            r.resolve({"Fn::Join": "not-a-list"})
        assert "Unresolvable Fn::Join" in caplog.text
