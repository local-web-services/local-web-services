"""Terminal output and status display for LDK CLI."""

from datetime import datetime

from rich.console import Console
from rich.table import Table

console = Console()


def print_banner(version: str, project_name: str) -> None:
    """Print startup banner with LDK version and project name.

    Displays a styled header line and a separator using Rich markup.
    """
    console.print(f"[bold cyan]LDK[/bold cyan] [dim]v{version}[/dim] - [bold]{project_name}[/bold]")
    console.print("[dim]" + "-" * 40 + "[/dim]")


def print_resource_summary(
    routes: list[dict],
    tables: list[str],
    functions: list[str],
    **kwargs: list[str],
) -> None:
    """Print a Rich table showing discovered resources.

    Args:
        routes: List of dicts with 'method', 'path', and optionally other keys.
        tables: List of table names.
        functions: List of function descriptors like "myFunc (python3.11)".
        **kwargs: Additional resource lists keyed by type label
            (e.g. queues, buckets, topics, state_machines, ecs_services).
    """
    table = Table(title="Discovered Resources")
    table.add_column("Type", style="bold")
    table.add_column("Name")
    table.add_column("Details")

    for route in routes:
        method = route.get("method", "GET")
        path = route.get("path", "/")
        handler = route.get("handler", "")
        table.add_row("API Route", path, f"{method} -> {handler}" if handler else method)

    for tbl_name in tables:
        table.add_row("Table", tbl_name, "")

    for func in functions:
        table.add_row("Function", func, "")

    _EXTRA_LABELS = {
        "queues": "Queue",
        "buckets": "Bucket",
        "topics": "Topic",
        "event_buses": "Event Bus",
        "state_machines": "State Machine",
        "ecs_services": "ECS Service",
        "user_pools": "User Pool",
    }
    for key, label in _EXTRA_LABELS.items():
        for name in kwargs.get(key, []):
            table.add_row(label, name, "")

    console.print(table)


def format_invocation_log(
    method: str, path: str, handler_name: str, duration_ms: float, status_code: int
) -> str:
    """Return a formatted invocation log string with Rich markup.

    Format: [HH:MM:SS] METHOD /path -> handler (Xms, STATUS)
    Status code is colored: green for 2xx, yellow for 4xx, red for 5xx.
    """
    now = datetime.now().strftime("%H:%M:%S")

    if 200 <= status_code < 300:
        status_style = "green"
    elif 400 <= status_code < 500:
        status_style = "yellow"
    elif 500 <= status_code < 600:
        status_style = "red"
    else:
        status_style = "white"

    duration_str = f"{duration_ms:.0f}ms"

    return (
        f"[dim][{now}][/dim] "
        f"[bold]{method}[/bold] {path} -> {handler_name} "
        f"({duration_str}, [{status_style}]{status_code}[/{status_style}])"
    )


def print_invocation(
    method: str, path: str, handler_name: str, duration_ms: float, status_code: int
) -> None:
    """Print the formatted invocation log to the console."""
    msg = format_invocation_log(method, path, handler_name, duration_ms, status_code)
    console.print(msg)


def print_error(message: str, detail: str | None = None) -> None:
    """Print an error message with Rich red formatting.

    Args:
        message: The main error message.
        detail: Optional extra detail printed in dimmed text.
    """
    console.print(f"[bold red]Error:[/bold red] {message}")
    if detail is not None:
        console.print(f"[dim]{detail}[/dim]")


def print_startup_complete(
    port: int,
    num_routes: int,
    num_tables: int,
    num_functions: int,
    **kwargs: int,
) -> None:
    """Print a startup-complete summary.

    Shows the listening URL and counts of discovered resources.

    Args:
        port: The primary listening port.
        num_routes: Number of API routes.
        num_tables: Number of DynamoDB tables.
        num_functions: Number of Lambda functions.
        **kwargs: Additional counts keyed by label
            (e.g. num_queues, num_buckets, num_topics, etc.).
    """
    console.print()
    console.print(
        f"[bold green]Ready![/bold green] Listening on [underline]http://localhost:{port}[/underline]"
    )
    parts = [
        f"{num_routes} route(s)",
        f"{num_tables} table(s)",
        f"{num_functions} function(s)",
    ]
    _EXTRA_COUNT_LABELS = {
        "num_queues": "queue(s)",
        "num_buckets": "bucket(s)",
        "num_topics": "topic(s)",
        "num_state_machines": "state machine(s)",
        "num_ecs_services": "ECS service(s)",
        "num_user_pools": "user pool(s)",
    }
    for key, label in _EXTRA_COUNT_LABELS.items():
        count = kwargs.get(key, 0)
        if count:
            parts.append(f"{count} {label}")
    console.print(f"  [dim]{', '.join(parts)}[/dim]")
