"""Tests for ldk.cli.display module."""

import io
import re

from rich.console import Console

from lws.cli import display
from lws.cli.display import (
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
    # Arrange
    expected_method = "POST"
    expected_path = "/orders"
    expected_handler = "createOrder"
    expected_duration = "152ms"
    expected_status = "200"
    expected_markup = "[green]"

    # Act
    result = format_invocation_log(expected_method, expected_path, expected_handler, 152.0, 200)

    # Assert
    assert expected_method in result, f"Expected {expected_method!r} to be in {result!r}"
    assert expected_path in result, f"Expected {expected_path!r} to be in {result!r}"
    assert expected_handler in result, f"Expected {expected_handler!r} to be in {result!r}"
    assert expected_duration in result, f"Expected {expected_duration!r} to be in {result!r}"
    assert expected_status in result, f"Expected {expected_status!r} to be in {result!r}"
    assert expected_markup in result, f"Expected {expected_markup!r} to be in {result!r}"


def test_format_invocation_log_500() -> None:
    """format_invocation_log returns correct format for a 500 response."""
    # Arrange
    expected_method = "GET"
    expected_path = "/health"
    expected_handler = "healthCheck"
    expected_duration = "10ms"
    expected_status = "500"
    expected_markup = "[red]"

    # Act
    result = format_invocation_log(expected_method, expected_path, expected_handler, 10.0, 500)

    # Assert
    assert expected_method in result, f"Expected {expected_method!r} to be in {result!r}"
    assert expected_path in result, f"Expected {expected_path!r} to be in {result!r}"
    assert expected_handler in result, f"Expected {expected_handler!r} to be in {result!r}"
    assert expected_duration in result, f"Expected {expected_duration!r} to be in {result!r}"
    assert expected_status in result, f"Expected {expected_status!r} to be in {result!r}"
    assert expected_markup in result, f"Expected {expected_markup!r} to be in {result!r}"


def test_format_invocation_log_404() -> None:
    """format_invocation_log returns yellow markup for 4xx."""
    # Arrange
    expected_status = "404"
    expected_markup = "[yellow]"

    # Act
    result = format_invocation_log("GET", "/missing", "notFound", 5.0, 404)

    # Assert
    assert expected_status in result, f"Expected {expected_status!r} to be in {result!r}"
    assert expected_markup in result, f"Expected {expected_markup!r} to be in {result!r}"


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
        assert "LDK" in output, f'Expected {"LDK"!r} to be in {output!r}'
        assert "0.1.0" in output, f'Expected {"0.1.0"!r} to be in {output!r}'
        assert "my-project" in output, f'Expected {"my-project"!r} to be in {output!r}'
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

        assert "API Route" in output, f'Expected {"API Route"!r} to be in {output!r}'
        assert "/users" in output, f'Expected {"/users"!r} to be in {output!r}'
        assert "listUsers" in output, f'Expected {"listUsers"!r} to be in {output!r}'
        assert "Table" in output, f'Expected {"Table"!r} to be in {output!r}'
        assert "UsersTable" in output, f'Expected {"UsersTable"!r} to be in {output!r}'
        assert "OrdersTable" in output, f'Expected {"OrdersTable"!r} to be in {output!r}'
        assert "Function" in output, f'Expected {"Function"!r} to be in {output!r}'
        assert "processOrder" in output, f'Expected {"processOrder"!r} to be in {output!r}'
        assert "sendEmail" in output, f'Expected {"sendEmail"!r} to be in {output!r}'
        assert "Local Details" in output, f'Expected {"Local Details"!r} to be in {output!r}'
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
            "API Route:/orders": (
                "lws apigateway test-invoke-method --resource /orders --http-method GET"
            ),
            "Table:OrdersTable": "lws dynamodb scan --table-name OrdersTable",
            "Function:processOrder": "ldk invoke processOrder",
            "Queue:MyQueue": "lws sqs receive-message --queue-name MyQueue",
        }

        print_resource_summary(
            routes, tables, functions, local_details=local_details, queues=["MyQueue"]
        )
        output = buf.getvalue()

        assert (
            "lws apigateway test-invoke-method --resource /orders --http-method GET" in output
        ), f"Expected to be in {output!r}"
        assert (
            "lws dynamodb scan --table-name OrdersTable" in output
        ), f'Expected {"lws dynamodb scan --table-name OrdersTable"!r} to be in {output!r}'
        assert (
            "ldk invoke processOrder" in output
        ), f'Expected {"ldk invoke processOrder"!r} to be in {output!r}'
        assert (
            "lws sqs receive-message --queue-name MyQueue" in output
        ), f'Expected {"lws sqs receive-message --queue-name MyQueue"!r} to be in {output!r}'
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
        assert "Error:" in output, f'Expected {"Error:"!r} to be in {output!r}'
        assert (
            "Something went wrong" in output
        ), f'Expected {"Something went wrong"!r} to be in {output!r}'
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
        assert "Error:" in output, f'Expected {"Error:"!r} to be in {output!r}'
        assert (
            "Connection failed" in output
        ), f'Expected {"Connection failed"!r} to be in {output!r}'
        assert "Retried 3 times" in output, f'Expected {"Retried 3 times"!r} to be in {output!r}'
    finally:
        display.console = original


def test_print_startup_complete() -> None:
    """print_startup_complete shows port and resource counts."""
    # Arrange
    expected_ready = "Ready!"
    expected_host = "localhost:3000"
    expected_routes = "5 route(s)"
    expected_tables = "2 table(s)"
    expected_functions = "3 function(s)"
    cons, buf = _capture_console()
    original = display.console
    display.console = cons

    # Act / Assert
    try:
        print_startup_complete(port=3000, num_routes=5, num_tables=2, num_functions=3)
        output = buf.getvalue()
        assert expected_ready in output, f"Expected {expected_ready!r} to be in {output!r}"
        assert expected_host in output, f"Expected {expected_host!r} to be in {output!r}"
        assert expected_routes in output, f"Expected {expected_routes!r} to be in {output!r}"
        assert expected_tables in output, f"Expected {expected_tables!r} to be in {output!r}"
        assert expected_functions in output, f"Expected {expected_functions!r} to be in {output!r}"
    finally:
        display.console = original
