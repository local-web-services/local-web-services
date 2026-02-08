"""Tests for ldk.cli.display module."""

import io
import re

from rich.console import Console

from ldk.cli import display
from ldk.cli.display import (
    format_invocation_log,
    print_banner,
    print_error,
    print_resource_summary,
    print_startup_complete,
)


def _capture_console() -> tuple[Console, io.StringIO]:
    """Create a Console that writes to a StringIO buffer and return both.

    Using highlight=False prevents Rich from auto-highlighting numbers and other
    patterns, which would insert ANSI codes that break substring assertions.
    """
    buf = io.StringIO()
    cons = Console(file=buf, force_terminal=True, width=120, highlight=False)
    return cons, buf


def test_format_invocation_log_200() -> None:
    """format_invocation_log returns correct format for a 200 response."""
    result = format_invocation_log("POST", "/orders", "createOrder", 152.0, 200)

    # Should contain the method, path, handler, duration, and status
    assert "POST" in result
    assert "/orders" in result
    assert "createOrder" in result
    assert "152ms" in result
    assert "200" in result
    # Green markup for 2xx
    assert "[green]" in result


def test_format_invocation_log_500() -> None:
    """format_invocation_log returns correct format for a 500 response."""
    result = format_invocation_log("GET", "/health", "healthCheck", 10.0, 500)

    assert "GET" in result
    assert "/health" in result
    assert "healthCheck" in result
    assert "10ms" in result
    assert "500" in result
    # Red markup for 5xx
    assert "[red]" in result


def test_format_invocation_log_404() -> None:
    """format_invocation_log returns yellow markup for 4xx."""
    result = format_invocation_log("GET", "/missing", "notFound", 5.0, 404)

    assert "404" in result
    assert "[yellow]" in result


def test_format_invocation_log_timestamp_format() -> None:
    """format_invocation_log includes an HH:MM:SS timestamp."""
    result = format_invocation_log("GET", "/", "index", 1.0, 200)
    # Search the raw markup string directly for an HH:MM:SS timestamp.
    # The timestamp appears as e.g. [14:05:32] in the markup output.
    assert re.search(r"\d{2}:\d{2}:\d{2}", result), f"No HH:MM:SS found in: {result}"


def test_print_banner_does_not_raise() -> None:
    """print_banner should not raise for typical input."""
    cons, buf = _capture_console()
    # Temporarily replace the module-level console
    original = display.console
    display.console = cons
    try:
        print_banner("0.1.0", "my-project")
        output = buf.getvalue()
        assert "LDK" in output
        assert "0.1.0" in output
        assert "my-project" in output
    finally:
        display.console = original


def test_print_resource_summary_with_sample_data() -> None:
    """print_resource_summary renders routes, tables, and functions."""
    cons, buf = _capture_console()
    original = display.console
    display.console = cons
    try:
        routes = [
            {"method": "GET", "path": "/users", "handler": "listUsers"},
            {"method": "POST", "path": "/users", "handler": "createUser"},
        ]
        tables = ["UsersTable", "OrdersTable"]
        functions = ["processOrder (python3.11)", "sendEmail (nodejs18.x)"]

        print_resource_summary(routes, tables, functions)
        output = buf.getvalue()

        assert "API Route" in output
        assert "/users" in output
        assert "listUsers" in output
        assert "Table" in output
        assert "UsersTable" in output
        assert "OrdersTable" in output
        assert "Function" in output
        assert "processOrder" in output
        assert "sendEmail" in output
        assert "Local Details" in output
    finally:
        display.console = original


def test_print_resource_summary_with_local_details() -> None:
    """print_resource_summary renders local details when provided."""
    cons, buf = _capture_console()
    original = display.console
    display.console = cons
    try:
        routes = [{"method": "GET", "path": "/orders", "handler": "getOrders"}]
        tables = ["OrdersTable"]
        functions = ["processOrder (python3.11)"]

        local_details = {
            "API Route:/orders": "http://localhost:3000/orders GET -> getOrders",
            "Table:OrdersTable": "http://localhost:3001 | AWS_ENDPOINT_URL_DYNAMODB",
            "Function:processOrder": "ldk invoke processOrder",
            "Queue:MyQueue": "http://localhost:3002 | AWS_ENDPOINT_URL_SQS",
        }

        print_resource_summary(
            routes, tables, functions, local_details=local_details, queues=["MyQueue"]
        )
        output = buf.getvalue()

        assert "http://localhost:3000/orders" in output
        assert "AWS_ENDPOINT_URL_DYNAMODB" in output
        assert "ldk invoke processOrder" in output
        assert "AWS_ENDPOINT_URL_SQS" in output
    finally:
        display.console = original


def test_print_error_without_detail() -> None:
    """print_error prints the error message without detail."""
    cons, buf = _capture_console()
    original = display.console
    display.console = cons
    try:
        print_error("Something went wrong")
        output = buf.getvalue()
        assert "Error:" in output
        assert "Something went wrong" in output
    finally:
        display.console = original


def test_print_error_with_detail() -> None:
    """print_error prints error message and detail text."""
    cons, buf = _capture_console()
    original = display.console
    display.console = cons
    try:
        print_error("Connection failed", detail="Retried 3 times")
        output = buf.getvalue()
        assert "Error:" in output
        assert "Connection failed" in output
        assert "Retried 3 times" in output
    finally:
        display.console = original


def test_print_startup_complete() -> None:
    """print_startup_complete shows port and resource counts."""
    cons, buf = _capture_console()
    original = display.console
    display.console = cons
    try:
        print_startup_complete(port=3000, num_routes=5, num_tables=2, num_functions=3)
        output = buf.getvalue()
        assert "Ready!" in output
        assert "localhost:3000" in output
        assert "5 route(s)" in output
        assert "2 table(s)" in output
        assert "3 function(s)" in output
    finally:
        display.console = original
