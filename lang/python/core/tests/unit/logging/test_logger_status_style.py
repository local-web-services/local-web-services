"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

from lws.logging.logger import _status_style


class TestStatusStyle:
    """Tests for the _status_style helper."""

    def test_2xx_is_green(self):
        expected_style = "green"
        assert (
            _status_style("200") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("200")!r}'
        assert (
            _status_style("201") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("201")!r}'

    def test_ok_is_green(self):
        expected_style = "green"
        assert (
            _status_style("OK") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("OK")!r}'

    def test_4xx_is_yellow(self):
        expected_style = "yellow"
        assert (
            _status_style("400") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("400")!r}'
        assert (
            _status_style("404") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("404")!r}'

    def test_5xx_is_red(self):
        expected_style = "red"
        assert (
            _status_style("500") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("500")!r}'
        assert (
            _status_style("503") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("503")!r}'

    def test_error_is_red(self):
        expected_style = "red"
        assert (
            _status_style("ERROR") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("ERROR")!r}'

    def test_unknown_is_white(self):
        expected_style = "white"
        assert (
            _status_style("123") == expected_style
        ), f'Expected {expected_style!r} but got {_status_style("123")!r}'
