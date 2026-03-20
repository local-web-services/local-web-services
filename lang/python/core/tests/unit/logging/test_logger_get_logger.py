"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

from lws.logging.logger import LdkLogger, get_logger


class TestGetLogger:
    """Tests for the get_logger factory function."""

    def test_returns_ldk_logger(self):
        log = get_logger("test.module")
        assert isinstance(log, LdkLogger), f"Expected instance of {LdkLogger!r} but got {type(log)!r}"

    def test_different_names_different_loggers(self):
        log1 = get_logger("a")
        log2 = get_logger("b")
        assert log1._logger is not log2._logger, "Expected value to be truthy"
