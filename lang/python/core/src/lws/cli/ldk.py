"""LDK CLI entry point.

Provides the ``ldk dev`` and ``ldk reset`` commands.
``ldk dev`` parses a CDK cloud assembly, builds the application graph,
starts local providers, and watches for file changes.
"""

from __future__ import annotations

import asyncio
import shutil
from pathlib import Path
from typing import Any

import typer
from rich.console import Console

from lws.cli._ldk_dev_runner import (  # noqa: F401  # pylint: disable=unused-import
    __version__,
    _load_config_quiet,
    _resolve_mode,
    _run_dev,
    _run_dev_terraform,
)
from lws.cli._ldk_http_registry import (  # noqa: F401  # pylint: disable=unused-import
    _build_gsi,
    _build_key_schema,
    _find_node_id,
)
from lws.cli._ldk_provider_factory import (  # noqa: F401  # pylint: disable=unused-import
    _create_providers,
)
from lws.cli._ldk_server import (  # noqa: F401  # pylint: disable=unused-import
    _create_terraform_providers,
)
from lws.cli.display import print_error

_console = Console()

app = typer.Typer(name="ldk", help="Local Development Kit - Run AWS CDK applications locally")


@app.callback()
def main() -> None:
    """LDK - Local Development Kit."""


@app.command()
def dev(
    port: int = typer.Option(None, "--port", "-p", help="API Gateway listen port"),
    no_persist: bool = typer.Option(False, "--no-persist", help="Disable data persistence"),
    force_synth: bool = typer.Option(False, "--force-synth", help="Force CDK synth"),
    log_level: str = typer.Option(
        None, "--log-level", "-l", help="Log level (debug/info/warning/error)"
    ),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
    mode: str = typer.Option(None, "--mode", "-m", help="Project mode (cdk or terraform)"),
    background: bool = typer.Option(
        False, "--background", "-b", help="Run in the background (detached)"
    ),
    seed: str = typer.Option(
        None, "--seed", help="Pre-populate Organizations from a seed (e.g. 'enterprise' or a path)"
    ),
) -> None:
    """Start the local development environment."""
    if background:
        _start_background(project_dir, port, no_persist, force_synth, log_level, mode)
        return
    try:
        asyncio.run(
            _run_dev(project_dir, port, no_persist, force_synth, log_level, mode, seed=seed)
        )
    except KeyboardInterrupt:
        pass


def _build_background_cmd(
    project_dir: Path,
    port: int | None,
    no_persist: bool,
    force_synth: bool,
    log_level: str | None,
    mode: str | None,
) -> list[str]:
    """Build the command-line args for a background ldk dev process."""
    import sys  # pylint: disable=import-outside-toplevel

    cmd = [sys.executable, "-m", "lws.cli.ldk", "dev", "--project-dir", str(project_dir)]
    if port is not None:
        cmd.extend(["--port", str(port)])
    if no_persist:
        cmd.append("--no-persist")
    if force_synth:
        cmd.append("--force-synth")
    if log_level:
        cmd.extend(["--log-level", log_level])
    if mode:
        cmd.extend(["--mode", mode])
    return cmd


def _start_background(
    project_dir: Path,
    port: int | None,
    no_persist: bool,
    force_synth: bool,
    log_level: str | None,
    mode: str | None,
) -> None:
    """Start ldk dev as a detached background process."""
    import subprocess  # pylint: disable=import-outside-toplevel

    project_dir = project_dir.resolve()
    config = _load_config_quiet(project_dir)
    actual_port = port if port is not None else config.port

    cmd = _build_background_cmd(project_dir, port, no_persist, force_synth, log_level, mode)

    log_dir = project_dir / ".lws"
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / "ldk-dev.log"

    with open(log_file, "w", encoding="utf-8") as fh:
        proc = subprocess.Popen(  # pylint: disable=consider-using-with
            cmd,
            stdout=fh,
            stderr=subprocess.STDOUT,
            start_new_session=True,
        )

    _console.print(f"[bold]Starting ldk dev in background (PID {proc.pid})...[/bold]")
    _console.print(f"  Log file: {log_file}")

    _wait_for_background_ready(proc, actual_port, log_file)


def _wait_for_background_ready(proc: Any, port: int, log_file: Path) -> None:
    """Poll until the background ldk dev is ready or times out."""
    import time  # pylint: disable=import-outside-toplevel

    import httpx  # pylint: disable=import-outside-toplevel

    deadline = time.monotonic() + 30
    while time.monotonic() < deadline:
        try:
            resp = httpx.get(f"http://localhost:{port}/_ldk/status", timeout=2.0)
            if resp.status_code == 200 and resp.json().get("running"):
                _console.print(f"[green]ldk dev is running on port {port}[/green]")
                _console.print(f"  Dashboard: http://localhost:{port}/_ldk/gui")
                _console.print(f"  Stop with: ldk stop --port {port}")
                return
        except (httpx.ConnectError, httpx.ConnectTimeout):
            pass
        time.sleep(0.5)

    if proc.poll() is not None:
        _console.print(f"[red]ldk dev exited with code {proc.returncode}[/red]")
        _console.print(f"  Check {log_file} for details")
        raise typer.Exit(1)

    _console.print("[yellow]ldk dev is starting but not yet ready (timed out waiting)[/yellow]")
    _console.print(f"  Check {log_file} for status")


@app.command()
def stop(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Stop a running ldk dev instance."""
    asyncio.run(_stop(port))


async def _stop(port: int) -> None:
    """Async implementation of the ``ldk stop`` command."""
    import httpx  # pylint: disable=import-outside-toplevel

    try:
        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"http://localhost:{port}/_ldk/shutdown",
                timeout=5.0,
            )
            resp.raise_for_status()
        _console.print("[green]ldk dev stopped.[/green]")
    except (httpx.ConnectError, httpx.ConnectTimeout):
        _console.print(f"[yellow]No ldk dev instance found on port {port}.[/yellow]")
    except Exception as exc:
        print_error("Failed to stop ldk dev", str(exc))
        raise typer.Exit(1)


@app.command()
def reset(
    yes: bool = typer.Option(False, "--yes", "-y", help="Skip confirmation prompt"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
    port: int = typer.Option(None, "--port", "-p", help="Management API port"),
) -> None:
    """Reset all LDK local state (databases, queues, etc.)."""
    project_dir = project_dir.resolve()
    config = _load_config_quiet(project_dir)
    data_dir = project_dir / config.data_dir

    if not data_dir.exists():
        _console.print("[dim]No data directory found. Nothing to reset.[/dim]")
        return

    # List contents to be deleted
    items = list(data_dir.iterdir())
    if not items:
        _console.print("[dim]Data directory is empty. Nothing to reset.[/dim]")
        return

    _console.print(f"[bold]Will delete all files under:[/bold] {data_dir}")
    for item in items:
        kind = "dir" if item.is_dir() else "file"
        _console.print(f"  [dim]{kind}:[/dim] {item.name}")

    if not yes:
        confirm = typer.confirm("Are you sure you want to delete all local state?")
        if not confirm:
            _console.print("[dim]Aborted.[/dim]")
            return

    # Delete contents
    deleted_count = 0
    for item in items:
        if item.is_dir():
            shutil.rmtree(item)
        else:
            item.unlink()
        deleted_count += 1

    _console.print(f"[green]Deleted {deleted_count} item(s) from {data_dir}[/green]")

    # Notify running ldk dev if possible
    mgmt_port = port or config.port
    asyncio.run(_try_management_reset(mgmt_port))


async def _try_management_reset(port: int) -> None:
    """Try to notify running ldk dev of the reset via management API."""
    try:
        import httpx  # pylint: disable=import-outside-toplevel

        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"http://localhost:{port}/_ldk/reset",
                timeout=5.0,
            )
            if resp.status_code == 200:
                _console.print("[dim]Notified running ldk dev of reset.[/dim]")
    except Exception:
        pass  # Server not running, that's fine


_SERVICE_IMAGES: dict[str, list[str]] = {
    "elasticache": ["redis:7-alpine"],
    "memorydb": ["redis:7-alpine"],
    "docdb": ["mongo:7"],
    "neptune": ["janusgraph/janusgraph:1.0"],
    "es": ["opensearchproject/opensearch:2"],
    "opensearch": ["opensearchproject/opensearch:2"],
    "rds": ["postgres:16-alpine", "mysql:8"],
}

_SUPPORTED_SERVICES = {"lambda"} | set(_SERVICE_IMAGES)


@app.command()
def setup(
    service: str = typer.Argument(..., help="Service to set up (e.g. 'lambda')"),
    runtime: str = typer.Option(
        None, "--runtime", "-r", help="Pull only a specific runtime (e.g. 'python3.12')"
    ),
) -> None:
    """Pull Docker images required for local service emulation."""
    if service == "all":
        _setup_all_services()
        return
    if service not in _SUPPORTED_SERVICES:
        print_error(
            "Unknown service",
            f"'{service}' is not supported. "
            f"Supported: {', '.join(sorted(_SUPPORTED_SERVICES))}, all",
        )
        raise typer.Exit(1)

    if service == "lambda":
        _setup_lambda(runtime)
    else:
        _setup_service_images(service)


def _setup_lambda(runtime_filter: str | None) -> None:
    """Pull official AWS Lambda base images from ECR Public."""
    from lws.providers.lambda_runtime.docker import (  # pylint: disable=import-outside-toplevel
        _RUNTIME_IMAGES,
        create_docker_client,
    )

    try:
        client = create_docker_client()
    except ImportError as exc:
        print_error(
            "Docker SDK not installed",
            "Install with: pip install local-web-services[docker]",
        )
        raise typer.Exit(1) from exc
    except Exception as exc:
        print_error("Cannot connect to Docker daemon", str(exc))
        raise typer.Exit(1)

    if runtime_filter:
        image = _RUNTIME_IMAGES.get(runtime_filter)
        if not image:
            print_error(
                "Unknown runtime",
                f"'{runtime_filter}' is not a supported runtime. "
                f"Supported: {', '.join(sorted(_RUNTIME_IMAGES))}",
            )
            raise typer.Exit(1)
        images_to_pull = {runtime_filter: image}
    else:
        images_to_pull = dict(_RUNTIME_IMAGES)

    for rt, image in images_to_pull.items():
        _console.print(f"[bold]Pulling[/bold] {image} [dim]({rt})[/dim]")
        try:
            client.images.pull(*image.rsplit(":", 1))
            _console.print("  [green]OK[/green]")
        except Exception as exc:
            _console.print(f"  [red]Failed:[/red] {exc}")

    _console.print("[bold green]Done.[/bold green]")


def _setup_service_images(service: str) -> None:
    """Pull Docker images for a specific service."""
    from lws.providers._shared.docker_client import (  # pylint: disable=import-outside-toplevel
        create_docker_client,
    )

    try:
        client = create_docker_client()
    except ImportError as exc:
        print_error(
            "Docker SDK not installed",
            "Install with: pip install local-web-services[docker]",
        )
        raise typer.Exit(1) from exc
    except Exception as exc:
        print_error("Cannot connect to Docker daemon", str(exc))
        raise typer.Exit(1)

    images = _SERVICE_IMAGES.get(service, [])
    for image in images:
        _console.print(f"[bold]Pulling[/bold] {image} [dim]({service})[/dim]")
        try:
            client.images.pull(*image.rsplit(":", 1))
            _console.print("  [green]OK[/green]")
        except Exception as exc:
            _console.print(f"  [red]Failed:[/red] {exc}")

    _console.print("[bold green]Done.[/bold green]")


def _setup_all_services() -> None:
    """Pull Docker images for all services."""
    _setup_lambda(None)
    for service in sorted(_SERVICE_IMAGES):
        _setup_service_images(service)
