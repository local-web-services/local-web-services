"""LDK CLI entry point.

Provides the ``ldk dev``, ``ldk invoke``, and ``ldk reset`` commands.
``ldk dev`` parses a CDK cloud assembly, builds the application graph,
starts local providers, and watches for file changes.
"""

from __future__ import annotations

import asyncio
import json
import logging
import shutil
from collections.abc import Callable
from pathlib import Path
from typing import Any

import typer
import uvicorn
from rich.console import Console
from rich.syntax import Syntax

from lws.cli.display import (
    print_banner,
    print_error,
    print_resource_summary,
    print_startup_complete,
)
from lws.config.loader import ConfigError, LdkConfig, load_config
from lws.graph.builder import AppGraph, NodeType, build_graph
from lws.interfaces import (
    ComputeConfig,
    GsiDefinition,
    ICompute,
    KeyAttribute,
    KeySchema,
    Provider,
    TableConfig,
)
from lws.parser.assembly import AppModel, parse_assembly
from lws.providers.apigateway.provider import ApiGatewayProvider, RouteConfig
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import PasswordPolicy, UserPoolConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app
from lws.providers.ecs.provider import EcsProvider
from lws.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
)
from lws.providers.lambda_runtime.nodejs import NodeJsCompute
from lws.providers.lambda_runtime.python import PythonCompute
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app
from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app
from lws.providers.sqs.provider import QueueConfig, RedrivePolicy, SqsProvider
from lws.providers.sqs.routes import create_sqs_app
from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from lws.runtime.env_builder import build_lambda_env
from lws.runtime.orchestrator import Orchestrator
from lws.runtime.sdk_env import build_sdk_env
from lws.runtime.synth import SynthError, ensure_synth
from lws.runtime.watcher import FileWatcher

_console = Console()

app = typer.Typer(name="ldk", help="Local Development Kit - Run AWS CDK applications locally")

__version__ = "0.4.0"


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
) -> None:
    """Start the local development environment."""
    try:
        asyncio.run(_run_dev(project_dir, port, no_persist, force_synth, log_level, mode))
    except KeyboardInterrupt:
        pass


@app.command()
def invoke(
    function_name: str = typer.Option(..., "--function-name", "-f", help="Lambda function name"),
    event: str = typer.Option(None, "--event", "-e", help="Inline JSON event payload"),
    event_file: Path = typer.Option(None, "--event-file", help="Path to JSON event file"),
    project_dir: Path = typer.Option(".", "--project-dir", "-d", help="Project root directory"),
    port: int = typer.Option(None, "--port", "-p", help="Management API port"),
) -> None:
    """Invoke a Lambda function directly."""
    asyncio.run(_run_invoke(function_name, event, event_file, project_dir, port))


async def _run_invoke(
    function_name: str,
    event_json: str | None,
    event_file: Path | None,
    project_dir: Path,
    port_override: int | None,
) -> None:
    """Async implementation of the ``ldk invoke`` command."""
    # Resolve event payload
    event_payload = _resolve_event_payload(event_json, event_file)

    # Try connecting to running ldk dev via management API
    project_dir = project_dir.resolve()
    config = _load_config_quiet(project_dir)
    mgmt_port = port_override or config.port

    if await _try_management_invoke(mgmt_port, function_name, event_payload):
        return

    # Fallback: one-shot invocation
    _console.print("[dim]No running ldk dev found, performing one-shot invocation...[/dim]")
    await _oneshot_invoke(project_dir, config, function_name, event_payload)


def _resolve_event_payload(event_json: str | None, event_file: Path | None) -> dict:
    """Parse event payload from CLI args."""
    if event_json is not None:
        try:
            return json.loads(event_json)
        except json.JSONDecodeError as exc:
            print_error("Invalid JSON in --event", str(exc))
            raise typer.Exit(1)

    if event_file is not None:
        if not event_file.exists():
            print_error("Event file not found", str(event_file))
            raise typer.Exit(1)
        try:
            return json.loads(event_file.read_text())
        except json.JSONDecodeError as exc:
            print_error("Invalid JSON in event file", str(exc))
            raise typer.Exit(1)

    return {}


async def _try_management_invoke(port: int, function_name: str, event: dict) -> bool:
    """Try to invoke via the management API. Return True if successful."""
    try:
        import httpx

        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"http://localhost:{port}/_ldk/invoke",
                json={"function_name": function_name, "event": event},
                timeout=30.0,
            )
            result = resp.json()
            formatted = json.dumps(result, indent=2)
            syntax = Syntax(formatted, "json", theme="monokai")
            _console.print(syntax)
            return True
    except Exception:
        return False


async def _oneshot_invoke(
    project_dir: Path, config: LdkConfig, function_name: str, event: dict
) -> None:
    """Perform a one-shot Lambda invocation without a running server."""
    try:
        import uuid as _uuid

        from lws.interfaces import InvocationResult, LambdaContext

        cdk_out = project_dir / config.cdk_out_dir
        if not cdk_out.exists():
            print_error("CDK output not found", f"Run 'cdk synth' first in {project_dir}")
            raise typer.Exit(1)

        app_model = parse_assembly(cdk_out)
        func_def = next((f for f in app_model.functions if f.name == function_name), None)
        if func_def is None:
            print_error("Function not found", f"No function named '{function_name}'")
            raise typer.Exit(1)

        sdk_env = build_sdk_env({})
        func_env = build_lambda_env(
            function_name=func_def.name,
            function_env=func_def.environment,
            local_endpoints={},
            resolved_refs={},
        )
        compute_config = ComputeConfig(
            function_name=func_def.name,
            handler=func_def.handler,
            runtime=func_def.runtime,
            code_path=func_def.code_path or Path("."),
            timeout=func_def.timeout,
            memory_size=func_def.memory,
            environment=func_env,
        )
        compute = NodeJsCompute(config=compute_config, sdk_env=sdk_env)
        await compute.start()

        request_id = str(_uuid.uuid4())
        context = LambdaContext(
            function_name=function_name,
            memory_limit_in_mb=compute_config.memory_size,
            timeout_seconds=compute_config.timeout,
            aws_request_id=request_id,
            invoked_function_arn=(
                f"arn:aws:lambda:us-east-1:000000000000:function:{function_name}"
            ),
        )

        result: InvocationResult = await compute.invoke(event, context)
        await compute.stop()

        output = result.payload if result.error is None else {"error": result.error}
        formatted = json.dumps(output, indent=2, default=str)
        syntax = Syntax(formatted, "json", theme="monokai")
        _console.print(syntax)

    except typer.Exit:
        raise
    except Exception as exc:
        print_error("Invocation failed", str(exc))
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
        import httpx

        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"http://localhost:{port}/_ldk/reset",
                timeout=5.0,
            )
            if resp.status_code == 200:
                _console.print("[dim]Notified running ldk dev of reset.[/dim]")
    except Exception:
        pass  # Server not running, that's fine


def _load_config_quiet(project_dir: Path) -> LdkConfig:
    """Load config without printing errors. Falls back to defaults."""
    try:
        return load_config(project_dir)
    except ConfigError:
        return LdkConfig()


def _load_and_apply_config(
    project_dir: Path,
    port_override: int | None,
    no_persist: bool,
    log_level_override: str | None,
) -> LdkConfig:
    """Load config and apply CLI overrides."""
    try:
        config = load_config(project_dir)
    except ConfigError as exc:
        print_error("Configuration error", str(exc))
        raise typer.Exit(1)

    if port_override is not None:
        config.port = port_override
    if log_level_override is not None:
        config.log_level = log_level_override
    if no_persist:
        config.persist = False

    logging.basicConfig(
        level=getattr(logging, config.log_level.upper(), logging.INFO),
        format="%(levelname)s %(name)s: %(message)s",
    )
    return config


def _collect_extra_resources(app_model: AppModel) -> dict[str, list[str]]:
    """Collect extra resource name lists from the app model for display."""
    extras: dict[str, list[str]] = {}
    _RESOURCE_ATTRS = {
        "queues": ("name", "queues"),
        "buckets": ("name", "buckets"),
        "topics": ("name", "topics"),
        "state_machines": ("name", "state_machines"),
        "ecs_services": ("service_name", "ecs_services"),
        "user_pools": ("user_pool_name", "user_pools"),
        "ssm_parameters": ("name", "ssm_parameters"),
        "secrets": ("name", "secrets"),
    }
    for key, (attr, model_attr) in _RESOURCE_ATTRS.items():
        items = getattr(app_model, model_attr, [])
        if items:
            extras[key] = [getattr(item, attr, str(item)) for item in items]
    return extras


def _build_local_details(app_model: AppModel, port: int) -> dict[str, str]:
    """Build a mapping of ``"Type:Name"`` to local detail strings."""
    details: dict[str, str] = {}

    _add_api_details(details, app_model)
    _add_resource_details(details, app_model)
    return details


def _add_api_details(details: dict[str, str], app_model: AppModel) -> None:
    """Add API route and Lambda function details."""
    for api_def in app_model.apis:
        for r in api_def.routes:
            details[f"API Route:{r.path}"] = (
                f"lws apigateway test-invoke-method --resource {r.path} --http-method {r.method}"
            )
    for f in app_model.functions:
        details[f"Function:{f.name}"] = f"ldk invoke {f.name}"


def _add_resource_details(details: dict[str, str], app_model: AppModel) -> None:
    """Add service resource details (DynamoDB, SQS, S3, etc.)."""
    for t in app_model.tables:
        details[f"Table:{t.name}"] = f"lws dynamodb scan --table-name {t.name}"
    for q in app_model.queues:
        details[f"Queue:{q.name}"] = f"lws sqs receive-message --queue-name {q.name}"
    for b in app_model.buckets:
        details[f"Bucket:{b.name}"] = f"lws s3api list-objects-v2 --bucket {b.name}"
    for t in app_model.topics:
        details[f"Topic:{t.name}"] = f"lws sns publish --topic-name {t.name} --message '...'"
    for b in app_model.event_buses:
        details[f"Event Bus:{b.name}"] = f"lws events list-rules --event-bus-name {b.name}"
    for sm in app_model.state_machines:
        details[f"State Machine:{sm.name}"] = f"lws stepfunctions start-execution --name {sm.name}"
    for p in app_model.user_pools:
        details[f"User Pool:{p.user_pool_name}"] = (
            f"lws cognito-idp sign-up --user-pool-name {p.user_pool_name}"
        )
    for p in app_model.ssm_parameters:
        details[f"Parameter:{p.name}"] = f"lws ssm get-parameter --name {p.name}"
    for s in app_model.secrets:
        details[f"Secret:{s.name}"] = f"lws secretsmanager get-secret-value --secret-id {s.name}"


def _display_summary(app_model: AppModel, port: int) -> None:
    """Print resource summary and startup-complete banner."""
    routes_info = [
        {"method": r.method, "path": r.path, "handler": r.handler_name or ""}
        for api_def in app_model.apis
        for r in api_def.routes
    ]
    tables_info = [t.name for t in app_model.tables]
    functions_info = [f"{f.name} ({f.runtime})" for f in app_model.functions]

    extra_resources = _collect_extra_resources(app_model)
    local_details = _build_local_details(app_model, port)
    print_resource_summary(
        routes_info, tables_info, functions_info, local_details=local_details, **extra_resources
    )

    extra_counts = {f"num_{k}": len(v) for k, v in extra_resources.items()}
    print_startup_complete(
        port,
        num_routes=len(routes_info),
        num_tables=len(tables_info),
        num_functions=len(functions_info),
        **extra_counts,
    )


def _resolve_mode(project_dir: Path, config: LdkConfig, mode_override: str | None) -> str:
    """Resolve the project mode from CLI flag, config, or auto-detection.

    Returns ``"cdk"`` or ``"terraform"``.
    Raises ``typer.Exit(1)`` on error.
    """
    from lws.terraform.detect import detect_project_type

    mode = mode_override or config.mode
    if mode:
        if mode not in ("cdk", "terraform"):
            print_error("Invalid mode", f"Must be 'cdk' or 'terraform', got '{mode}'")
            raise typer.Exit(1)
        return mode

    detected = detect_project_type(project_dir)
    if detected == "ambiguous":
        print_error(
            "Ambiguous project",
            "Both .tf files and cdk.out found. Use --mode cdk or --mode terraform.",
        )
        raise typer.Exit(1)
    if detected == "none":
        print_error(
            "No project found",
            "No .tf files or cdk.out directory found. "
            "Run from a CDK or Terraform project directory.",
        )
        raise typer.Exit(1)
    return detected


async def _run_dev_terraform(project_dir: Path, config: LdkConfig) -> None:
    """Run the dev server in Terraform mode.

    Starts all service providers in always-on mode, generates the
    Terraform provider override file, and waits for shutdown.
    """
    from lws.terraform.gitignore import ensure_gitignore
    from lws.terraform.override import cleanup_override, generate_override

    port = config.port
    data_dir = project_dir / config.data_dir
    data_dir.mkdir(parents=True, exist_ok=True)

    # Generate override file
    try:
        override_path = generate_override(port, project_dir)
    except FileExistsError as exc:
        print_error("Override file conflict", str(exc))
        raise typer.Exit(1)

    ensure_gitignore(project_dir)

    # Create all providers in always-on mode (no app model)
    providers, ports = _create_terraform_providers(config, data_dir, project_dir)

    orchestrator = Orchestrator()

    # Enable WebSocket log streaming
    from lws.logging.logger import WebSocketLogHandler, set_ws_handler

    ws_log_handler = WebSocketLogHandler()
    set_ws_handler(ws_log_handler)

    # Build resource metadata so the CLI client can discover services
    resource_metadata: dict[str, Any] = {
        "port": port,
        "services": {
            svc_name: {"port": svc_port, "resources": []} for svc_name, svc_port in ports.items()
        },
    }

    # Mount management API (no compute providers in terraform mode)
    _mount_management_api(providers, orchestrator, {}, port, resource_metadata)

    for key in providers:
        pass  # All keys are already in the dict

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

    try:
        await orchestrator.wait_for_shutdown()
    finally:
        cleanup_override(project_dir)
        set_ws_handler(None)
        await orchestrator.stop()
        typer.echo("Goodbye")


def _create_terraform_providers(
    config: LdkConfig,
    data_dir: Path,
    project_dir: Path | None = None,
) -> tuple[dict[str, Provider], dict[str, int]]:
    """Create all service providers for Terraform mode (no app model)."""
    providers: dict[str, Provider] = {}

    port = config.port
    ports = {
        "dynamodb": port + 1,
        "sqs": port + 2,
        "s3": port + 3,
        "sns": port + 4,
        "eventbridge": port + 5,
        "stepfunctions": port + 6,
        "cognito": port + 7,
        "apigateway": port + 8,
        "lambda": port + 9,
        "iam": port + 10,
        "sts": port + 11,
        "ssm": port + 12,
        "secretsmanager": port + 13,
    }

    dynamo_provider = SqliteDynamoProvider(data_dir=data_dir, tables=[])
    sqs_provider = SqsProvider()
    s3_provider = S3Provider(data_dir=data_dir)
    sns_provider = SnsProvider()
    eb_provider = EventBridgeProvider()
    sf_provider = StepFunctionsProvider()

    pool_config = UserPoolConfig(
        user_pool_id="us-east-1_default",
        user_pool_name="default",
    )
    cognito_provider = CognitoProvider(data_dir=data_dir, config=pool_config)

    _register_http_providers(
        providers,
        dynamo_provider=dynamo_provider,
        sqs_provider=sqs_provider,
        s3_provider=s3_provider,
        sns_provider=sns_provider,
        eb_provider=eb_provider,
        sf_provider=sf_provider,
        cognito_provider=cognito_provider,
        ports=ports,
    )

    # Shared Lambda registry for Lambda management and API Gateway V2 proxy
    from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app

    lambda_registry = LambdaRegistry()

    # Wire Lambda registry compute providers into Step Functions so SFN can
    # invoke Lambda functions that Terraform creates dynamically.
    sf_provider.set_compute_providers(lambda_registry._compute)

    # Build SDK env so Lambda functions can reach local services
    local_endpoints: dict[str, str] = {
        "dynamodb": f"http://127.0.0.1:{ports['dynamodb']}",
        "sqs": f"http://127.0.0.1:{ports['sqs']}",
        "s3": f"http://127.0.0.1:{ports['s3']}",
        "sns": f"http://127.0.0.1:{ports['sns']}",
        "events": f"http://127.0.0.1:{ports['eventbridge']}",
        "stepfunctions": f"http://127.0.0.1:{ports['stepfunctions']}",
        "cognito-idp": f"http://127.0.0.1:{ports['cognito']}",
        "ssm": f"http://127.0.0.1:{ports['ssm']}",
        "secretsmanager": f"http://127.0.0.1:{ports['secretsmanager']}",
    }
    sdk_env = build_sdk_env(local_endpoints)

    # Lambda management API
    providers["__lambda_http__"] = _HttpServiceProvider(
        "lambda-http",
        lambda: create_lambda_management_app(lambda_registry, project_dir, sdk_env),
        ports["lambda"],
    )

    # API Gateway management API with V2 support and Lambda proxy
    from lws.providers.apigateway.routes import create_apigateway_management_app

    providers["__apigateway_http__"] = _HttpServiceProvider(
        "apigateway-http",
        lambda: create_apigateway_management_app(lambda_registry),
        ports["apigateway"],
    )

    # IAM stub
    from lws.providers.iam.routes import create_iam_app

    providers["__iam_http__"] = _HttpServiceProvider("iam-http", create_iam_app, ports["iam"])

    # STS stub
    from lws.providers.sts.routes import create_sts_app

    providers["__sts_http__"] = _HttpServiceProvider("sts-http", create_sts_app, ports["sts"])

    # SSM Parameter Store
    from lws.providers.ssm.routes import create_ssm_app

    providers["__ssm_http__"] = _HttpServiceProvider("ssm-http", create_ssm_app, ports["ssm"])

    # Secrets Manager
    from lws.providers.secretsmanager.routes import create_secretsmanager_app

    providers["__secretsmanager_http__"] = _HttpServiceProvider(
        "secretsmanager-http", create_secretsmanager_app, ports["secretsmanager"]
    )

    return providers, ports


def _has_any_resources(app_model: AppModel) -> bool:
    """Return True if the app model contains at least one resource."""
    return bool(
        app_model.functions
        or app_model.tables
        or app_model.apis
        or app_model.queues
        or app_model.buckets
        or app_model.topics
        or app_model.event_buses
        or app_model.state_machines
        or app_model.ecs_services
        or app_model.user_pools
        or app_model.ssm_parameters
        or app_model.secrets
    )


async def _run_dev(
    project_dir: Path,
    port_override: int | None,
    no_persist: bool,
    force_synth: bool,
    log_level_override: str | None,
    mode_override: str | None = None,
) -> None:
    """Async implementation of the ``ldk dev`` command."""
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
    providers, compute_providers = _create_providers(app_model, graph, config, data_dir)

    orchestrator = Orchestrator()

    # Enable WebSocket log streaming
    from lws.logging.logger import WebSocketLogHandler, set_ws_handler

    ws_log_handler = WebSocketLogHandler()
    set_ws_handler(ws_log_handler)

    # Mount management API
    resource_metadata = _build_resource_metadata(app_model, config.port)
    _mount_management_api(
        providers, orchestrator, compute_providers, config.port, resource_metadata
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

    _display_summary(app_model, config.port)
    typer.echo(f"  Dashboard: http://localhost:{config.port}/_ldk/gui")

    watcher = FileWatcher(
        watch_dir=project_dir,
        include_patterns=config.watch_include,
        exclude_patterns=config.watch_exclude,
    )
    watcher.on_change(lambda path: logging.getLogger("ldk.watcher").info("Changed: %s", path))
    watcher.start()

    try:
        await orchestrator.wait_for_shutdown()
    finally:
        watcher.stop()
        set_ws_handler(None)
        await orchestrator.stop()
        typer.echo("Goodbye")


def _create_dynamo_providers(
    app_model: AppModel,
    graph: AppGraph,
    data_dir: Path,
) -> tuple[SqliteDynamoProvider, dict[str, Provider]]:
    """Create DynamoDB table providers from the app model.

    Always returns a provider (even with no CDK tables) so the DynamoDB
    HTTP endpoint is available for Terraform/CLI table creation.
    """
    providers: dict[str, Provider] = {}
    table_configs: list[TableConfig] = []
    for table in app_model.tables:
        ks = _build_key_schema(table.key_schema)
        gsi_defs = [_build_gsi(g) for g in table.gsi_definitions]
        table_configs.append(
            TableConfig(table_name=table.name, key_schema=ks, gsi_definitions=gsi_defs)
        )

    dynamo_provider = SqliteDynamoProvider(data_dir=data_dir, tables=table_configs)
    for table in app_model.tables:
        node_id = _find_node_id(graph, NodeType.DYNAMODB_TABLE, table.name)
        if node_id:
            providers[node_id] = dynamo_provider
    return dynamo_provider, providers


def _create_compute_providers(
    app_model: AppModel,
    graph: AppGraph,
    local_endpoints: dict[str, str],
    sdk_env: dict[str, str],
) -> tuple[dict[str, ICompute], dict[str, Provider]]:
    """Create Lambda compute providers from the app model (Node.js + Python)."""
    providers: dict[str, Provider] = {}
    compute_providers: dict[str, ICompute] = {}
    for func in app_model.functions:
        func_env = build_lambda_env(
            function_name=func.name,
            function_env=func.environment,
            local_endpoints=local_endpoints,
            resolved_refs={},
        )
        compute_config = ComputeConfig(
            function_name=func.name,
            handler=func.handler,
            runtime=func.runtime,
            code_path=func.code_path or Path("."),
            timeout=func.timeout,
            memory_size=func.memory,
            environment=func_env,
        )
        if func.runtime.startswith("python"):
            compute: ICompute = PythonCompute(config=compute_config, sdk_env=sdk_env)
        elif func.runtime.startswith("nodejs"):
            compute = NodeJsCompute(config=compute_config, sdk_env=sdk_env)
        else:
            logging.getLogger("ldk.cli").warning(
                "Unsupported runtime %s for %s, skipping", func.runtime, func.name
            )
            continue
        compute_providers[func.name] = compute
        node_id = _find_node_id(graph, NodeType.LAMBDA_FUNCTION, func.name)
        if node_id:
            providers[node_id] = compute
    return compute_providers, providers


def _create_api_providers(
    app_model: AppModel,
    graph: AppGraph,
    compute_providers: dict[str, ICompute],
    port: int,
) -> tuple[ApiGatewayProvider | None, dict[str, Provider]]:
    """Create API Gateway providers from the app model."""
    providers: dict[str, Provider] = {}
    api_provider: ApiGatewayProvider | None = None
    for api_def in app_model.apis:
        route_configs = [
            RouteConfig(method=r.method, path=r.path, handler_name=r.handler_name)
            for r in api_def.routes
            if r.handler_name and r.handler_name in compute_providers
        ]
        if route_configs:
            api_provider = ApiGatewayProvider(
                routes=route_configs, compute_providers=compute_providers, port=port
            )
            node_id = _find_node_id(graph, NodeType.API_GATEWAY, api_def.name)
            if node_id:
                providers[node_id] = api_provider
    return api_provider, providers


def _create_sqs_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[SqsProvider, dict[str, Provider]]:
    """Create SQS queue providers from the app model.

    Always returns a provider (even with no CDK queues) so the SQS
    HTTP endpoint is available for Terraform/CLI queue creation.
    """
    providers: dict[str, Provider] = {}
    queue_configs = []
    for q in app_model.queues:
        redrive = None
        if q.redrive_target:
            redrive = RedrivePolicy(
                dead_letter_queue_name=q.redrive_target, max_receive_count=q.max_receive_count
            )
        queue_configs.append(
            QueueConfig(
                queue_name=q.name,
                visibility_timeout=q.visibility_timeout,
                is_fifo=q.is_fifo,
                content_based_dedup=q.content_based_dedup,
                redrive_policy=redrive,
            )
        )
    sqs_provider = SqsProvider(queues=queue_configs if queue_configs else None)
    for q in app_model.queues:
        node_id = _find_node_id(graph, NodeType.SQS_QUEUE, q.name)
        if node_id:
            providers[node_id] = sqs_provider
    return sqs_provider, providers


def _create_s3_providers(
    app_model: AppModel,
    graph: AppGraph,
    data_dir: Path,
) -> tuple[S3Provider, dict[str, Provider]]:
    """Create S3 bucket providers from the app model.

    Always returns a provider (even with no CDK buckets) so the S3
    HTTP endpoint is available for Terraform/CLI bucket creation.
    """
    providers: dict[str, Provider] = {}
    bucket_names = [b.name for b in app_model.buckets]
    s3_provider = S3Provider(data_dir=data_dir, buckets=bucket_names if bucket_names else None)
    for b in app_model.buckets:
        node_id = _find_node_id(graph, NodeType.S3_BUCKET, b.name)
        if node_id:
            providers[node_id] = s3_provider
    return s3_provider, providers


def _create_sns_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[SnsProvider, dict[str, Provider]]:
    """Create SNS topic providers from the app model.

    Always returns a provider (even with no CDK topics) so the SNS
    HTTP endpoint is available for Terraform/CLI topic creation.
    """
    providers: dict[str, Provider] = {}
    topic_configs = [
        TopicConfig(topic_name=t.name, topic_arn=t.topic_arn) for t in app_model.topics
    ]
    sns_provider = SnsProvider(topics=topic_configs if topic_configs else None)
    for t in app_model.topics:
        node_id = _find_node_id(graph, NodeType.SNS_TOPIC, t.name)
        if node_id:
            providers[node_id] = sns_provider
    return sns_provider, providers


def _create_eventbridge_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[EventBridgeProvider, dict[str, Provider]]:
    """Create EventBridge providers from the app model.

    Always returns a provider (even with no CDK buses) so the EventBridge
    HTTP endpoint is available for Terraform/CLI event bus creation.
    """
    providers: dict[str, Provider] = {}
    bus_configs = [
        EventBusConfig(bus_name=b.name, bus_arn=b.bus_arn) for b in app_model.event_buses
    ]
    rule_configs = []
    for r in app_model.event_rules:
        targets = [
            RuleTarget(target_id=t["target_id"], arn=t["arn"], input_path=t.get("input_path"))
            for t in r.targets
        ]
        rule_configs.append(
            RuleConfig(
                rule_name=r.rule_name,
                event_bus_name=r.event_bus_name,
                event_pattern=r.event_pattern,
                schedule_expression=r.schedule_expression,
                targets=targets,
            )
        )
    eb_provider = EventBridgeProvider(
        buses=bus_configs if bus_configs else None,
        rules=rule_configs if rule_configs else None,
    )
    for b in app_model.event_buses:
        node_id = _find_node_id(graph, NodeType.EVENT_BUS, b.name)
        if node_id:
            providers[node_id] = eb_provider
    return eb_provider, providers


def _create_stepfunctions_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[StepFunctionsProvider, dict[str, Provider]]:
    """Create Step Functions providers from the app model.

    Always returns a provider (even with no CDK state machines) so the
    Step Functions HTTP endpoint is available for Terraform/CLI creation.
    """
    providers: dict[str, Provider] = {}
    sm_configs = []
    for sm in app_model.state_machines:
        wf_type = WorkflowType.EXPRESS if sm.workflow_type == "EXPRESS" else WorkflowType.STANDARD
        sm_configs.append(
            StateMachineConfig(
                name=sm.name,
                definition=sm.definition,
                workflow_type=wf_type,
                role_arn=sm.role_arn,
                definition_substitutions=sm.definition_substitutions,
            )
        )
    sf_provider = StepFunctionsProvider(
        state_machines=sm_configs if sm_configs else None,
    )
    for sm in app_model.state_machines:
        node_id = _find_node_id(graph, NodeType.STATE_MACHINE, sm.name)
        if node_id:
            providers[node_id] = sf_provider
    return sf_provider, providers


def _create_ecs_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[EcsProvider, dict[str, Provider]]:
    """Create ECS service providers from the app model.

    Always returns a provider (even with no CDK services).
    """
    providers: dict[str, Provider] = {}
    ecs_provider = EcsProvider(
        services=app_model.ecs_services if app_model.ecs_services else None,
    )
    for svc in app_model.ecs_services:
        svc_name = getattr(svc, "service_name", str(id(svc)))
        node_id = _find_node_id(graph, NodeType.ECS_SERVICE, svc_name)
        if node_id:
            providers[node_id] = ecs_provider
    return ecs_provider, providers


def _create_cognito_providers(
    app_model: AppModel,
    data_dir: Path,
    compute_providers: dict[str, ICompute],
) -> tuple[CognitoProvider, dict[str, Provider]]:
    """Create Cognito user pool providers from the app model.

    Always returns a provider (even with no CDK user pools) so the
    Cognito HTTP endpoint is available for Terraform/CLI user pool creation.
    """
    providers: dict[str, Provider] = {}
    if not app_model.user_pools:
        pool_config = UserPoolConfig(
            user_pool_id="us-east-1_default",
            user_pool_name="default",
        )
        cognito_provider = CognitoProvider(data_dir=data_dir, config=pool_config)
        return cognito_provider, providers
    # Use the first user pool (multi-pool support can be added later)
    pool = app_model.user_pools[0]
    pw = pool.password_policy
    password_policy = PasswordPolicy(
        minimum_length=int(pw.get("MinimumLength", 8)),
        require_lowercase=bool(pw.get("RequireLowercase", True)),
        require_uppercase=bool(pw.get("RequireUppercase", True)),
        require_digits=bool(pw.get("RequireNumbers", pw.get("RequireDigits", True))),
        require_symbols=bool(pw.get("RequireSymbols", False)),
    )
    pool_config = UserPoolConfig(
        user_pool_id=f"us-east-1_{pool.logical_id}",
        user_pool_name=pool.user_pool_name,
        password_policy=password_policy,
        auto_confirm=pool.auto_confirm,
        client_id=pool.client_id or "local-client-id",
        pre_authentication_trigger=pool.pre_auth_trigger,
        post_confirmation_trigger=pool.post_confirm_trigger,
    )
    trigger_funcs = {}
    if pool.pre_auth_trigger and pool.pre_auth_trigger in compute_providers:
        trigger_funcs["PreAuthentication"] = compute_providers[pool.pre_auth_trigger]
    if pool.post_confirm_trigger and pool.post_confirm_trigger in compute_providers:
        trigger_funcs["PostConfirmation"] = compute_providers[pool.post_confirm_trigger]
    cognito_provider = CognitoProvider(
        data_dir=data_dir, config=pool_config, trigger_functions=trigger_funcs or None
    )
    providers[f"__cognito_{pool.logical_id}__"] = cognito_provider
    return cognito_provider, providers


def _wire_remaining_providers(
    app_model: AppModel,
    graph: AppGraph,
    providers: dict[str, Provider],
    compute_providers: dict[str, ICompute],
    sqs_provider: SqsProvider,
    local_endpoints: dict[str, str],
    data_dir: Path,
    api_port: int,
    *,
    sns_port: int,
    eb_port: int,
    sf_port: int,
    cognito_port: int,
) -> tuple[
    SnsProvider,
    EventBridgeProvider,
    StepFunctionsProvider,
    CognitoProvider,
]:
    """Wire messaging, cognito, and API Gateway providers."""
    sns_provider, sns_providers = _create_sns_providers(app_model, graph)
    providers.update(sns_providers)
    sns_provider.set_compute_providers(compute_providers)
    sns_provider.set_queue_provider(sqs_provider)
    local_endpoints["sns"] = f"http://127.0.0.1:{sns_port}"

    eb_provider, eb_providers = _create_eventbridge_providers(app_model, graph)
    providers.update(eb_providers)
    eb_provider.set_compute_providers(compute_providers)
    local_endpoints["events"] = f"http://127.0.0.1:{eb_port}"

    sf_provider, sf_providers = _create_stepfunctions_providers(app_model, graph)
    providers.update(sf_providers)
    sf_provider.set_compute_providers(compute_providers)
    local_endpoints["stepfunctions"] = f"http://127.0.0.1:{sf_port}"

    cognito_provider, cognito_providers = _create_cognito_providers(
        app_model, data_dir, compute_providers
    )
    providers.update(cognito_providers)
    local_endpoints["cognito-idp"] = f"http://127.0.0.1:{cognito_port}"

    api_provider, api_providers = _create_api_providers(
        app_model, graph, compute_providers, api_port
    )
    providers.update(api_providers)

    return sns_provider, eb_provider, sf_provider, cognito_provider


def _create_providers(
    app_model: AppModel,
    graph: AppGraph,
    config: LdkConfig,
    data_dir: Path,
) -> tuple[dict[str, Provider], dict[str, ICompute]]:
    """Instantiate providers from the parsed app model.

    Returns a tuple of (provider map, compute_providers).
    """
    providers: dict[str, Provider] = {}

    # Port allocation: base+1 DynamoDB, +2 SQS, +3 S3, +4 SNS, +5 EventBridge,
    # +6 Step Functions, +7 Cognito, +12 SSM, +13 Secrets Manager
    dynamo_port = config.port + 1
    sqs_port = config.port + 2
    s3_port = config.port + 3
    sns_port = config.port + 4
    eb_port = config.port + 5
    sf_port = config.port + 6
    cognito_port = config.port + 7
    ssm_port = config.port + 12
    secretsmanager_port = config.port + 13

    # 1. Storage providers (no deps)
    dynamo_provider, dynamo_providers = _create_dynamo_providers(app_model, graph, data_dir)
    providers.update(dynamo_providers)

    sqs_provider, sqs_providers = _create_sqs_providers(app_model, graph)
    providers.update(sqs_providers)

    s3_provider, s3_providers = _create_s3_providers(app_model, graph, data_dir)
    providers.update(s3_providers)

    # 2. Build local_endpoints for SDK env redirection
    local_endpoints: dict[str, str] = {}
    local_endpoints["dynamodb"] = f"http://127.0.0.1:{dynamo_port}"
    local_endpoints["sqs"] = f"http://127.0.0.1:{sqs_port}"
    local_endpoints["s3"] = f"http://127.0.0.1:{s3_port}"

    # 3. Compute (Lambda — Node.js + Python)
    sdk_env = build_sdk_env(local_endpoints)
    compute_providers, compute_graph_providers = _create_compute_providers(
        app_model, graph, local_endpoints, sdk_env
    )
    providers.update(compute_graph_providers)

    # 4-6. Messaging, ECS, Cognito, API Gateway
    sns_provider, eb_provider, sf_provider, cognito_provider = _wire_remaining_providers(
        app_model,
        graph,
        providers,
        compute_providers,
        sqs_provider,
        local_endpoints,
        data_dir,
        config.port,
        sns_port=sns_port,
        eb_port=eb_port,
        sf_port=sf_port,
        cognito_port=cognito_port,
    )
    ecs_provider, ecs_providers = _create_ecs_providers(app_model, graph)
    providers.update(ecs_providers)

    # 7. Add SSM and Secrets Manager endpoints, rebuild SDK env, update compute
    local_endpoints["ssm"] = f"http://127.0.0.1:{ssm_port}"
    local_endpoints["secretsmanager"] = f"http://127.0.0.1:{secretsmanager_port}"
    sdk_env = build_sdk_env(local_endpoints)
    for compute in compute_providers.values():
        if hasattr(compute, "_sdk_env"):
            compute._sdk_env = sdk_env

    # 8. Create HTTP servers for each active service
    _register_http_providers(
        providers,
        dynamo_provider=dynamo_provider,
        sqs_provider=sqs_provider,
        s3_provider=s3_provider,
        sns_provider=sns_provider,
        eb_provider=eb_provider,
        sf_provider=sf_provider,
        cognito_provider=cognito_provider,
        ports={
            "dynamodb": dynamo_port,
            "sqs": sqs_port,
            "s3": s3_port,
            "sns": sns_port,
            "eventbridge": eb_port,
            "stepfunctions": sf_port,
            "cognito": cognito_port,
        },
    )

    # 9. SSM Parameter Store and Secrets Manager (pre-seeded from CloudFormation)
    from lws.providers.secretsmanager.routes import create_secretsmanager_app
    from lws.providers.ssm.routes import create_ssm_app

    ssm_params = [
        {"name": p.name, "type": p.type, "value": p.value, "description": p.description}
        for p in app_model.ssm_parameters
    ]
    sm_secrets = [
        {"name": s.name, "description": s.description, "secret_string": s.secret_string}
        for s in app_model.secrets
    ]

    providers["__ssm_http__"] = _HttpServiceProvider(
        "ssm-http", lambda: create_ssm_app(ssm_params), ssm_port
    )
    providers["__secretsmanager_http__"] = _HttpServiceProvider(
        "secretsmanager-http", lambda: create_secretsmanager_app(sm_secrets), secretsmanager_port
    )

    return providers, compute_providers


def _register_http_providers(
    providers: dict[str, Provider],
    *,
    dynamo_provider: SqliteDynamoProvider,
    sqs_provider: SqsProvider,
    s3_provider: S3Provider,
    sns_provider: SnsProvider,
    eb_provider: EventBridgeProvider,
    sf_provider: StepFunctionsProvider,
    cognito_provider: CognitoProvider,
    ports: dict[str, int],
) -> None:
    """Register HTTP service providers for each active backend."""
    from lws.providers.cognito.routes import create_cognito_app
    from lws.providers.eventbridge.routes import create_eventbridge_app
    from lws.providers.stepfunctions.routes import create_stepfunctions_app

    http_services: list[tuple[str, Any, Callable[[], Any]]] = []
    http_services.append(
        ("dynamodb", ports["dynamodb"], lambda p=dynamo_provider: create_dynamodb_app(p))
    )
    http_services.append(
        ("sqs", ports["sqs"], lambda p=sqs_provider, pt=ports["sqs"]: create_sqs_app(p, pt))
    )
    http_services.append(("s3", ports["s3"], lambda p=s3_provider: create_s3_app(p)))
    http_services.append(("sns", ports["sns"], lambda p=sns_provider: create_sns_app(p)))
    http_services.append(
        ("eventbridge", ports["eventbridge"], lambda p=eb_provider: create_eventbridge_app(p))
    )
    http_services.append(
        (
            "stepfunctions",
            ports["stepfunctions"],
            lambda p=sf_provider: create_stepfunctions_app(p),
        )
    )
    http_services.append(
        ("cognito", ports["cognito"], lambda p=cognito_provider: create_cognito_app(p))
    )

    for svc_name, port, factory in http_services:
        providers[f"__{svc_name}_http__"] = _HttpServiceProvider(f"{svc_name}-http", factory, port)


class _HttpServiceProvider(Provider):
    """Generic wrapper that runs any FastAPI app as a uvicorn-served Provider."""

    def __init__(self, service_name: str, app_factory: Callable[[], Any], port: int) -> None:
        self._service_name = service_name
        self._app_factory = app_factory
        self._port = port
        self._server: uvicorn.Server | None = None
        self._task: asyncio.Task | None = None  # type: ignore[type-arg]

    @property
    def name(self) -> str:
        return self._service_name

    async def start(self) -> None:
        http_app = self._app_factory()
        uvi_config = uvicorn.Config(
            app=http_app,
            host="0.0.0.0",
            port=self._port,
            log_level="warning",
        )
        self._server = uvicorn.Server(uvi_config)
        self._task = asyncio.create_task(self._server.serve())
        # Wait for the server to actually bind before reporting as started
        for _ in range(50):
            if self._server.started:
                break
            await asyncio.sleep(0.1)

    async def stop(self) -> None:
        if self._server is not None:
            self._server.should_exit = True
        if self._task is not None:
            await self._task
            self._task = None
        self._server = None

    async def health_check(self) -> bool:
        return self._server is not None


def _build_resource_metadata(app_model: AppModel, port: int) -> dict[str, Any]:
    """Build resource metadata for the ``/_ldk/resources`` endpoint."""
    metadata: dict[str, Any] = {"port": port, "services": {}}
    services = metadata["services"]
    ports = _service_ports(port)

    _add_api_metadata(services, app_model, port)
    _add_service_metadata(services, app_model, ports)
    return metadata


def _service_ports(port: int) -> dict[str, int]:
    """Return a mapping of service name to port number."""
    return {
        "dynamodb": port + 1,
        "sqs": port + 2,
        "s3": port + 3,
        "sns": port + 4,
        "events": port + 5,
        "stepfunctions": port + 6,
        "cognito-idp": port + 7,
        "ssm": port + 12,
        "secretsmanager": port + 13,
    }


def _add_api_metadata(services: dict[str, Any], app_model: AppModel, port: int) -> None:
    """Add API Gateway metadata to services."""
    if not app_model.apis:
        return
    routes = []
    for api_def in app_model.apis:
        for r in api_def.routes:
            routes.append(
                {
                    "name": api_def.name,
                    "path": r.path,
                    "method": r.method,
                    "handler": r.handler_name or "",
                }
            )
    services["apigateway"] = {"port": port, "resources": routes}


def _add_service_metadata(
    services: dict[str, Any], app_model: AppModel, ports: dict[str, int]
) -> None:
    """Add non-API service metadata to services."""
    if app_model.functions:
        services["lambda"] = {
            "resources": [
                {
                    "name": f.name,
                    "runtime": f.runtime,
                    "arn": f"arn:aws:lambda:us-east-1:000000000000:function:{f.name}",
                }
                for f in app_model.functions
            ],
        }
    if app_model.tables:
        services["dynamodb"] = {
            "port": ports["dynamodb"],
            "resources": [{"name": t.name} for t in app_model.tables],
        }
    if app_model.queues:
        sqs_port = ports["sqs"]
        services["sqs"] = {
            "port": sqs_port,
            "resources": [
                {
                    "name": q.name,
                    "queue_url": f"http://localhost:{sqs_port}/000000000000/{q.name}",
                }
                for q in app_model.queues
            ],
        }
    if app_model.buckets:
        services["s3"] = {
            "port": ports["s3"],
            "resources": [{"name": b.name} for b in app_model.buckets],
        }
    if app_model.topics:
        services["sns"] = {
            "port": ports["sns"],
            "resources": [
                {
                    "name": t.name,
                    "arn": t.topic_arn or f"arn:aws:sns:us-east-1:000000000000:{t.name}",
                }
                for t in app_model.topics
            ],
        }
    _add_extended_service_metadata(services, app_model, ports)


def _add_extended_service_metadata(
    services: dict[str, Any], app_model: AppModel, ports: dict[str, int]
) -> None:
    """Add EventBridge, Step Functions, Cognito, SSM and Secrets Manager metadata."""
    if app_model.event_buses:
        services["events"] = {
            "port": ports["events"],
            "resources": [
                {
                    "name": b.name,
                    "arn": b.bus_arn or f"arn:aws:events:us-east-1:000000000000:event-bus/{b.name}",
                }
                for b in app_model.event_buses
            ],
        }
    if app_model.state_machines:
        services["stepfunctions"] = {
            "port": ports["stepfunctions"],
            "resources": [
                {
                    "name": sm.name,
                    "arn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{sm.name}",
                }
                for sm in app_model.state_machines
            ],
        }
    if app_model.user_pools:
        services["cognito-idp"] = {
            "port": ports["cognito-idp"],
            "resources": [
                {"name": p.user_pool_name, "user_pool_id": f"us-east-1_{p.logical_id}"}
                for p in app_model.user_pools
            ],
        }
    if app_model.ssm_parameters:
        services["ssm"] = {
            "port": ports["ssm"],
            "resources": [{"name": p.name} for p in app_model.ssm_parameters],
        }
    if app_model.secrets:
        services["secretsmanager"] = {
            "port": ports["secretsmanager"],
            "resources": [
                {
                    "name": s.name,
                    "arn": f"arn:aws:secretsmanager:us-east-1:000000000000:secret:{s.name}",
                }
                for s in app_model.secrets
            ],
        }


def _mount_management_api(
    providers: dict[str, Provider],
    orchestrator: Orchestrator,
    compute_providers: dict[str, ICompute],
    port: int,
    resource_metadata: dict[str, Any] | None = None,
) -> None:
    """Mount the management API router on the API Gateway app or create a standalone one."""
    from fastapi import FastAPI

    from lws.api.management import create_management_router

    mgmt_router = create_management_router(
        orchestrator, compute_providers, providers, resource_metadata=resource_metadata
    )

    # Try to find an existing API Gateway provider to mount on
    for key, prov in providers.items():
        if isinstance(prov, ApiGatewayProvider):
            prov.app.include_router(mgmt_router)
            return

    # No API Gateway — create a standalone FastAPI app for management
    mgmt_app = FastAPI(title="LDK Management")
    mgmt_app.include_router(mgmt_router)
    providers["__management_http__"] = _HttpServiceProvider(
        "management-http", lambda: mgmt_app, port
    )


def _find_node_id(graph: AppGraph, node_type: NodeType, name: str) -> str | None:
    """Find a graph node ID by type and name."""
    for nid, node in graph.nodes.items():
        if node.node_type == node_type and nid == name:
            return nid
    # Fallback: check config
    for nid, node in graph.nodes.items():
        if node.node_type == node_type:
            if node.config.get("table_name") == name or node.config.get("handler") == name:
                return nid
    return name


def _build_key_schema(raw_schema: list[dict[str, str]]) -> KeySchema:
    """Convert raw key schema dicts to a KeySchema dataclass."""
    pk: KeyAttribute | None = None
    sk: KeyAttribute | None = None
    for ks in raw_schema:
        attr = KeyAttribute(name=ks.get("attribute_name", "pk"), type=ks.get("type", "S"))
        if ks.get("key_type") == "RANGE":
            sk = attr
        else:
            pk = attr
    if pk is None:
        pk = KeyAttribute(name="pk", type="S")
    return KeySchema(partition_key=pk, sort_key=sk)


def _build_gsi(raw_gsi: dict) -> GsiDefinition:
    """Convert a raw GSI dict to a GsiDefinition dataclass."""
    index_name = raw_gsi.get("index_name", raw_gsi.get("IndexName", "gsi"))
    ks_raw = raw_gsi.get("key_schema", [])
    ks = _build_key_schema(ks_raw)
    projection = raw_gsi.get("projection_type", "ALL")
    return GsiDefinition(index_name=index_name, key_schema=ks, projection_type=projection)
