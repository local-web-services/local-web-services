"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

from ldk.logging.logger import _status_style


class TestStatusStyle:
    """Tests for the _status_style helper."""

    def test_2xx_is_green(self):
        assert _status_style("200") == "green"
        assert _status_style("201") == "green"

    def test_ok_is_green(self):
        assert _status_style("OK") == "green"

    def test_4xx_is_yellow(self):
        assert _status_style("400") == "yellow"
        assert _status_style("404") == "yellow"

    def test_5xx_is_red(self):
        assert _status_style("500") == "red"
        assert _status_style("503") == "red"

    def test_error_is_red(self):
        assert _status_style("ERROR") == "red"

    def test_unknown_is_white(self):
        assert _status_style("123") == "white"
