"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

import logging

from ldk.logging.logger import LdkLogger, _status_style, get_logger


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


class TestGetLogger:
    """Tests for the get_logger factory function."""

    def test_returns_ldk_logger(self):
        log = get_logger("test.module")
        assert isinstance(log, LdkLogger)

    def test_different_names_different_loggers(self):
        log1 = get_logger("a")
        log2 = get_logger("b")
        assert log1._logger is not log2._logger


class TestLdkLoggerLevels:
    """Tests for log level filtering."""

    def test_set_level(self):
        log = get_logger("test.levels")
        log.set_level("debug")
        assert log.level == logging.DEBUG

    def test_set_level_uppercase(self):
        log = get_logger("test.levels.upper")
        log.set_level("WARNING")
        assert log.level == logging.WARNING

    def test_is_enabled_for(self):
        log = get_logger("test.enabled")
        log.set_level("warning")
        assert log.is_enabled_for(logging.WARNING)
        assert log.is_enabled_for(logging.ERROR)
        assert not log.is_enabled_for(logging.DEBUG)

    def test_debug_not_printed_at_info_level(self):
        log = get_logger("test.filter.debug")
        log.set_level("info")
        # Should not raise; debug is silently ignored at INFO level
        log.debug("This should be suppressed")

    def test_info_not_printed_at_warning_level(self):
        log = get_logger("test.filter.info")
        log.set_level("warning")
        log.info("This should be suppressed")


class TestLdkLoggerFormatting:
    """Tests for structured log formatting methods."""

    def test_log_http_request_at_info(self):
        """Verify log_http_request doesn't raise and accepts valid args."""
        log = get_logger("test.http")
        log.set_level("info")
        # Should not raise
        log.log_http_request(
            method="POST",
            path="/orders",
            handler_name="createOrder",
            duration_ms=234.0,
            status_code=201,
        )

    def test_log_http_request_suppressed_at_warning(self):
        """Verify log_http_request is silent when log level is too high."""
        log = get_logger("test.http.suppress")
        log.set_level("warning")
        # Should not raise or print
        log.log_http_request(
            method="GET",
            path="/test",
            handler_name="handler",
            duration_ms=10.0,
            status_code=200,
        )

    def test_log_sqs_invocation(self):
        """Verify log_sqs_invocation doesn't raise and accepts valid args."""
        log = get_logger("test.sqs")
        log.set_level("info")
        log.log_sqs_invocation(
            queue_name="OrderQueue",
            handler_name="processOrder",
            message_count=1,
            duration_ms=156.0,
            status="OK",
        )

    def test_log_sqs_plural_msgs(self):
        """Verify plural form for multiple messages."""
        log = get_logger("test.sqs.plural")
        log.set_level("info")
        log.log_sqs_invocation(
            queue_name="Q",
            handler_name="h",
            message_count=5,
            duration_ms=100.0,
        )

    def test_log_dynamodb_operation(self):
        """Verify log_dynamodb_operation doesn't raise and accepts valid args."""
        log = get_logger("test.dynamo")
        log.set_level("info")
        log.log_dynamodb_operation(
            operation="PutItem",
            table_name="orders",
            duration_ms=3.0,
            status="OK",
        )

    def test_log_dynamodb_error_status(self):
        """Verify error status is accepted."""
        log = get_logger("test.dynamo.err")
        log.set_level("info")
        log.log_dynamodb_operation(
            operation="GetItem",
            table_name="users",
            duration_ms=15.0,
            status="ERROR",
        )

    def test_standard_log_methods(self):
        """Verify debug/info/warning/error don't raise."""
        log = get_logger("test.standard")
        log.set_level("debug")
        log.debug("debug message")
        log.info("info message")
        log.warning("warning message")
        log.error("error message")

    def test_log_with_format_args(self):
        """Verify log methods support %-style formatting."""
        log = get_logger("test.format")
        log.set_level("debug")
        log.debug("value is %d", 42)
        log.info("name is %s", "test")
