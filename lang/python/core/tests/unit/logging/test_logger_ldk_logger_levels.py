"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

import logging

from lws.logging.logger import get_logger


class TestLdkLoggerLevels:
    """Tests for log level filtering."""

    def test_set_level(self):
        log = get_logger("test.levels")
        log.set_level("debug")
        assert log.level == logging.DEBUG, f"Expected {logging.DEBUG!r} but got {log.level!r}"

    def test_set_level_uppercase(self):
        log = get_logger("test.levels.upper")
        log.set_level("WARNING")
        assert log.level == logging.WARNING, f"Expected {logging.WARNING!r} but got {log.level!r}"

    def test_is_enabled_for(self):
        log = get_logger("test.enabled")
        log.set_level("warning")
        assert log.is_enabled_for(logging.WARNING), "Expected value to be truthy"
        assert log.is_enabled_for(logging.ERROR), "Expected value to be truthy"
        assert not log.is_enabled_for(logging.DEBUG), "Expected value to be falsy"

    def test_debug_not_printed_at_info_level(self):
        log = get_logger("test.filter.debug")
        log.set_level("info")
        # Should not raise; debug is silently ignored at INFO level
        log.debug("This should be suppressed")

    def test_info_not_printed_at_warning_level(self):
        log = get_logger("test.filter.info")
        log.set_level("warning")
        log.info("This should be suppressed")
