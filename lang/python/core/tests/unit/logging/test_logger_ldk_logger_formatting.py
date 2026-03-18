"""Unit tests for the LDK structured logging framework."""

from __future__ import annotations

from lws.logging.logger import get_logger


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
