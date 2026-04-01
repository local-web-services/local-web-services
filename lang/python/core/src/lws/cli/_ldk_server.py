"""Server startup and run logic for the LDK dev server.

Contains ``_create_terraform_providers``, ``_run_dev_terraform``, and
``_run_dev`` — the functions that actually build the provider graph and
drive the async server lifecycle.

Display and config-loading helpers live in ``_ldk_dev_runner``.
"""

from __future__ import annotations

import logging
import tempfile
from pathlib import Path
from typing import Any

import typer

from lws.cli._ldk_http_registry import (
    _CoreProviderSet,
    _mount_management_api,
    _register_http_providers_from_set,
)
from lws.cli._ldk_provider_factory import (
    _create_chaos_configs,
    _create_iam_auth_bundle,
    _create_lifecycle_configs,
    _create_providers,
    _load_aws_fake_configs,
    _register_experimental_providers,
    _register_fake_provider,
)
from lws.cli._ldk_providers_extended import _register_organizations_provider
from lws.cli._ldk_resource_metadata import _build_resource_metadata, _service_ports
from lws.cli.display import print_error
from lws.cli.experimental import EXPERIMENTAL_SERVICES
from lws.config.loader import LdkConfig
from lws.interfaces import Provider
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.aws_lifecycle import TrackerRegistry
from lws.providers._shared.aws_operation_fake import AwsFakeConfig
from lws.runtime.orchestrator import Orchestrator
from lws.runtime.sdk_env import build_sdk_env
from lws.runtime.synth import SynthError, ensure_synth
from lws.runtime.watcher import FileWatcher

try:
    from importlib.metadata import version as _pkg_version

    __version__ = _pkg_version("local-web-services")
except Exception:
    __version__ = "0.0.0"


def _create_terraform_providers(
    config: LdkConfig,
    data_dir: Path,
    project_dir: Path | None = None,
    iam_auth_bundle: IamAuthBundle | None = None,
    registry: TrackerRegistry | None = None,
) -> tuple[
    dict[str, Provider],
    dict[str, int],
    dict[str, Any],
    dict[str, AwsFakeConfig],
    dict[str, Any],
]:
    """Create all service providers for Terraform mode (no app model)."""
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
    )

    providers: dict[str, Provider] = {}

    port = config.port
    ports = _service_ports(port)
    ports["apigateway"] = port + 8
    ports["iam"] = port + 10
    ports["sts"] = port + 11

    _core_set = _CoreProviderSet.from_data_dir(data_dir)
    providers["__cognito_default__"] = _core_set.cognito_provider

    chaos_configs = _create_chaos_configs()
    aws_fake_configs = _load_aws_fake_configs(project_dir)
    lifecycle_configs = _create_lifecycle_configs()
    if iam_auth_bundle is None:
        iam_auth_bundle = _create_iam_auth_bundle(config, project_dir)
    _register_http_providers_from_set(
        providers,
        _core_set,
        ports,
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        iam_auth=iam_auth_bundle,
        lifecycle_configs=lifecycle_configs,
    )

    # Shared Lambda registry for Lambda management and API Gateway V2 proxy
    from lws.providers.lambda_runtime.routes import (  # pylint: disable=import-outside-toplevel
        LambdaRegistry,
        create_lambda_management_app,
    )

    lambda_registry = LambdaRegistry()

    # Wire Lambda registry compute providers into Step Functions so SFN can
    # invoke Lambda functions that Terraform creates dynamically.
    _core_set.sf_provider.set_compute_providers(lambda_registry.compute)

    # Build SDK env so Lambda functions can reach local services
    local_endpoints: dict[str, str] = {
        "dynamodb": f"http://127.0.0.1:{ports['dynamodb']}",
        "sqs": f"http://127.0.0.1:{ports['sqs']}",
        "s3": f"http://127.0.0.1:{ports['s3']}",
        "sns": f"http://127.0.0.1:{ports['sns']}",
        "events": f"http://127.0.0.1:{ports['events']}",
        "stepfunctions": f"http://127.0.0.1:{ports['stepfunctions']}",
        "cognito-idp": f"http://127.0.0.1:{ports['cognito-idp']}",
        "ssm": f"http://127.0.0.1:{ports['ssm']}",
        "secretsmanager": f"http://127.0.0.1:{ports['secretsmanager']}",
        "organizations": f"http://127.0.0.1:{ports['organizations']}",
    }
    sdk_env = build_sdk_env(local_endpoints)

    # Lambda management API
    providers["__lambda_http__"] = _HttpServiceProvider(
        "lambda-http",
        lambda: create_lambda_management_app(lambda_registry, project_dir, sdk_env),
        ports["lambda"],
    )

    # API Gateway management API with V2 support and Lambda proxy
    from lws.providers.apigateway.routes import (  # pylint: disable=import-outside-toplevel
        create_apigateway_management_app,
    )

    providers["__apigateway_http__"] = _HttpServiceProvider(
        "apigateway-http",
        lambda: create_apigateway_management_app(lambda_registry),
        ports["apigateway"],
    )

    # IAM stub
    from lws.providers.iam.routes import create_iam_app  # pylint: disable=import-outside-toplevel

    providers["__iam_http__"] = _HttpServiceProvider(
        "iam-http",
        lambda: create_iam_app(
            chaos=chaos_configs.get("iam"), aws_fake=aws_fake_configs.get("iam")
        ),
        ports["iam"],
    )

    # STS stub
    from lws.providers.sts.routes import create_sts_app  # pylint: disable=import-outside-toplevel

    providers["__sts_http__"] = _HttpServiceProvider("sts-http", create_sts_app, ports["sts"])

    # Organizations
    _register_organizations_provider(
        providers,
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        organizations_port=ports["organizations"],
    )

    # SSM Parameter Store
    from lws.providers.ssm.routes import create_ssm_app  # pylint: disable=import-outside-toplevel

    providers["__ssm_http__"] = _HttpServiceProvider(
        "ssm-http",
        lambda ia=iam_auth_bundle: create_ssm_app(
            chaos=chaos_configs.get("ssm"),
            aws_fake=aws_fake_configs.get("ssm"),
            iam_auth=ia,
        ),
        ports["ssm"],
    )

    # Secrets Manager
    from lws.providers.secretsmanager.routes import (  # pylint: disable=import-outside-toplevel
        create_secretsmanager_app,
    )

    providers["__secretsmanager_http__"] = _HttpServiceProvider(
        "secretsmanager-http",
        lambda ia=iam_auth_bundle: create_secretsmanager_app(
            chaos=chaos_configs.get("secretsmanager"),
            aws_fake=aws_fake_configs.get("secretsmanager"),
            iam_auth=ia,
        ),
        ports["secretsmanager"],
    )

    _register_experimental_providers(providers, ports, registry=registry)

    # Fake server provider
    _register_fake_provider(providers, port, project_dir)

    return providers, ports, chaos_configs, aws_fake_configs, lifecycle_configs


async def _run_dev_terraform(project_dir: Path, config: LdkConfig) -> None:
    """Run the dev server in Terraform mode.

    Starts all service providers in always-on mode, generates the
    Terraform provider override file, and waits for shutdown.
    """
    from rich.console import Console  # pylint: disable=import-outside-toplevel

    from lws.terraform.gitignore import ensure_gitignore  # pylint: disable=import-outside-toplevel
    from lws.terraform.override import (  # pylint: disable=import-outside-toplevel
        cleanup_override,
        generate_override,
    )

    _console = Console()

    port = config.port
    if config.persist:
        data_dir = project_dir / config.data_dir
        data_dir.mkdir(parents=True, exist_ok=True)
    else:
        data_dir = Path(tempfile.mkdtemp(prefix="ldk-"))

    # Generate override file
    try:
        override_path = generate_override(port, project_dir)
    except FileExistsError as exc:
        print_error("Override file conflict", str(exc))
        raise typer.Exit(1)

    ensure_gitignore(project_dir)

    # Create all providers in always-on mode (no app model)
    iam_auth_bundle = _create_iam_auth_bundle(config, project_dir)
    tracker_registry: TrackerRegistry = {}
    providers, ports, chaos_configs, aws_fake_configs, lifecycle_configs = (
        _create_terraform_providers(
            config,
            data_dir,
            project_dir,
            iam_auth_bundle=iam_auth_bundle,
            registry=tracker_registry,
        )
    )

    orchestrator = Orchestrator()

    # Enable WebSocket log streaming
    from lws.logging.logger import (  # pylint: disable=import-outside-toplevel
        WebSocketLogHandler,
        set_ws_handler,
    )

    ws_log_handler = WebSocketLogHandler()
    set_ws_handler(ws_log_handler)

    # Build resource metadata so the CLI client can discover services
    resource_metadata: dict[str, Any] = {
        "port": port,
        "services": {
            svc_name: {"port": svc_port, "resources": []} for svc_name, svc_port in ports.items()
        },
    }

    # Mount management API
    _mount_management_api(
        providers,
        orchestrator,
        port,
        resource_metadata,
        chaos_configs,
        aws_fake_configs,
        iam_auth_bundle=iam_auth_bundle,
        lifecycle_configs=lifecycle_configs,
        tracker_registry=tracker_registry,
    )

    startup_order = list(providers.keys())

    try:
        await orchestrator.start(providers, startup_order)
    except Exception as exc:
        cleanup_override(project_dir)
        print_error("Failed to start providers", str(exc))
        raise typer.Exit(1)

    # Display summary
    _console.print()
    _console.print("[bold green]Terraform mode active[/bold green]")
    _console.print(f"  Override file: {override_path}")
    _console.print()
    _console.print("[bold]Service endpoints:[/bold]")
    for svc_name, svc_port in sorted(ports.items()):
        _console.print(f"  {svc_name:20s} http://localhost:{svc_port}")
    _console.print()
    _console.print("[dim]Run 'terraform init && terraform apply' to create resources.[/dim]")
    _console.print(f"  Dashboard: http://localhost:{config.port}/_ldk/gui")
    _console.print()

    _print_experimental_banner(ports)
    try:
        await orchestrator.wait_for_shutdown()
    finally:
        cleanup_override(project_dir)
        set_ws_handler(None)
        await orchestrator.stop()
        typer.echo("Goodbye")


def _print_experimental_banner(ports: dict[str, int]) -> None:
    """Print a banner listing active experimental services."""
    from rich.console import Console  # pylint: disable=import-outside-toplevel

    _console = Console()
    active = sorted(s for s in EXPERIMENTAL_SERVICES if s in ports)
    if not active:
        return
    _console.print("[bold yellow]Experimental services:[/bold yellow]")
    _console.print(f"  {', '.join(active)}")
    _console.print("[dim]  These services may change or be removed in future releases.[/dim]")
    _console.print()


def _start_watcher(project_dir: Path, config: Any) -> Any:
    """Create, configure, and start a FileWatcher for the project."""
    watcher = FileWatcher(
        watch_dir=project_dir,
        include_patterns=config.watch_include,
        exclude_patterns=config.watch_exclude,
    )
    watcher.on_change(lambda path: logging.getLogger("ldk.watcher").info("Changed: %s", path))
    watcher.start()
    return watcher


def _build_furl_ports(app_model: Any, base_port: int) -> dict[str, int]:
    """Build function URL → port mapping for display."""
    furl_ports: dict[str, int] = {}
    for furl in app_model.function_urls:
        idx = list(f.function_name for f in app_model.function_urls).index(furl.function_name)
        furl_ports[furl.function_name] = base_port + 23 + idx
    return furl_ports


async def _run_dev(
    project_dir: Path,
    port_override: int | None,
    no_persist: bool,
    force_synth: bool,
    log_level_override: str | None,
    mode_override: str | None = None,
) -> None:
    """Async implementation of the ``ldk dev`` command."""
    from lws.cli._ldk_dev_runner import (  # pylint: disable=import-outside-toplevel
        _display_summary,
        _has_any_resources,
        _load_and_apply_config,
        _resolve_mode,
    )
    from lws.cli.display import print_banner  # pylint: disable=import-outside-toplevel
    from lws.graph.builder import build_graph  # pylint: disable=import-outside-toplevel
    from lws.parser.assembly import parse_assembly  # pylint: disable=import-outside-toplevel

    project_dir = project_dir.resolve()
    config = _load_and_apply_config(project_dir, port_override, no_persist, log_level_override)
    print_banner(__version__, project_dir.name)

    # Resolve project mode
    resolved_mode = _resolve_mode(project_dir, config, mode_override)
    if resolved_mode == "terraform":
        await _run_dev_terraform(project_dir, config)
        return

    try:
        cdk_out = await ensure_synth(project_dir, force=force_synth)
    except SynthError as exc:
        print_error("CDK synth failed", str(exc))
        raise typer.Exit(1)

    app_model = parse_assembly(cdk_out)
    if not _has_any_resources(app_model):
        print_error("No resources found in cloud assembly", str(cdk_out))
        raise typer.Exit(1)

    graph = build_graph(app_model)
    startup_order = graph.topological_sort()

    data_dir = project_dir / config.data_dir
    data_dir.mkdir(parents=True, exist_ok=True)
    iam_auth_bundle = _create_iam_auth_bundle(config, project_dir)
    providers, chaos_configs, aws_fake_configs, lifecycle_configs = _create_providers(
        app_model, graph, config, data_dir, iam_auth_bundle=iam_auth_bundle
    )

    orchestrator = Orchestrator()

    # Enable WebSocket log streaming
    from lws.logging.logger import (  # pylint: disable=import-outside-toplevel
        WebSocketLogHandler,
        set_ws_handler,
    )

    ws_log_handler = WebSocketLogHandler()
    set_ws_handler(ws_log_handler)

    # Mount management API
    resource_metadata = _build_resource_metadata(app_model, config.port)
    _mount_management_api(
        providers,
        orchestrator,
        config.port,
        resource_metadata,
        chaos_configs,
        aws_fake_configs,
        iam_auth_bundle=iam_auth_bundle,
        lifecycle_configs=lifecycle_configs,
    )

    # Append non-graph provider keys (HTTP servers, management) to startup order.
    # This must happen after _mount_management_api so the fallback management
    # HTTP server (when no API Gateway exists) is included in the startup order.
    for key in providers:
        if key not in startup_order:
            startup_order.append(key)

    try:
        await orchestrator.start(providers, startup_order)
    except Exception as exc:
        print_error("Failed to start providers", str(exc))
        raise typer.Exit(1)

    # Build function URL port mapping for display
    furl_ports = _build_furl_ports(app_model, config.port)
    _display_summary(app_model, config.port, furl_ports if furl_ports else None)
    typer.echo(f"  Dashboard: http://localhost:{config.port}/_ldk/gui")

    _print_experimental_banner(_service_ports(config.port))

    watcher = _start_watcher(project_dir, config)

    try:
        await orchestrator.wait_for_shutdown()
    finally:
        watcher.stop()
        set_ws_handler(None)
        await orchestrator.stop()
        typer.echo("Goodbye")
