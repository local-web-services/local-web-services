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

from ldk.cli.display import (
    print_banner,
    print_error,
    print_resource_summary,
    print_startup_complete,
)
from ldk.config.loader import ConfigError, LdkConfig, load_config
from ldk.graph.builder import AppGraph, NodeType, build_graph
from ldk.interfaces import (
    ComputeConfig,
    GsiDefinition,
    ICompute,
    KeyAttribute,
    KeySchema,
    Provider,
    TableConfig,
)
from ldk.parser.assembly import AppModel, parse_assembly
from ldk.providers.apigateway.provider import ApiGatewayProvider, RouteConfig
from ldk.providers.cognito.provider import CognitoProvider
from ldk.providers.cognito.user_store import PasswordPolicy, UserPoolConfig
from ldk.providers.dynamodb.provider import SqliteDynamoProvider
from ldk.providers.dynamodb.routes import create_dynamodb_app
from ldk.providers.ecs.provider import EcsProvider
from ldk.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
)
from ldk.providers.lambda_runtime.nodejs import NodeJsCompute
from ldk.providers.lambda_runtime.python import PythonCompute
from ldk.providers.s3.provider import S3Provider
from ldk.providers.s3.routes import create_s3_app
from ldk.providers.sns.provider import SnsProvider, TopicConfig
from ldk.providers.sns.routes import create_sns_app
from ldk.providers.sqs.provider import QueueConfig, RedrivePolicy, SqsProvider
from ldk.providers.sqs.routes import create_sqs_app
from ldk.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from ldk.runtime.env_builder import build_lambda_env
from ldk.runtime.orchestrator import Orchestrator
from ldk.runtime.sdk_env import build_sdk_env
from ldk.runtime.synth import SynthError, ensure_synth
from ldk.runtime.watcher import FileWatcher

_console = Console()

app = typer.Typer(name="ldk", help="Local Development Kit - Run AWS CDK applications locally")

__version__ = "0.1.0"


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
) -> None:
    """Start the local development environment."""
    try:
        asyncio.run(_run_dev(project_dir, port, no_persist, force_synth, log_level))
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

        from ldk.interfaces import InvocationResult, LambdaContext

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
    }
    for key, (attr, model_attr) in _RESOURCE_ATTRS.items():
        items = getattr(app_model, model_attr, [])
        if items:
            extras[key] = [getattr(item, attr, str(item)) for item in items]
    return extras


def _build_local_details(app_model: AppModel, port: int) -> dict[str, str]:
    """Build a mapping of ``"Type:Name"`` to local detail strings."""
    details: dict[str, str] = {}

    # Port allocation mirrors _create_providers
    dynamo_port = port + 1
    sqs_port = port + 2
    s3_port = port + 3
    sns_port = port + 4
    eb_port = port + 5
    sf_port = port + 6
    cognito_port = port + 7

    # API routes: browsable URL with method and handler
    for api_def in app_model.apis:
        for r in api_def.routes:
            method = r.method
            handler = r.handler_name or ""
            url = f"http://localhost:{port}{r.path}"
            suffix = f" {method} -> {handler}" if handler else f" {method}"
            details[f"API Route:{r.path}"] = url + suffix

    # DynamoDB tables
    for t in app_model.tables:
        details[f"Table:{t.name}"] = (
            f"http://localhost:{dynamo_port} | AWS_ENDPOINT_URL_DYNAMODB"
        )

    # Lambda functions
    for f in app_model.functions:
        details[f"Function:{f.name}"] = f"ldk invoke {f.name}"

    # SDK-backed services: endpoint URL | env var
    _SERVICE_DETAILS: list[tuple[str, str, str, int]] = [
        ("queues", "name", "AWS_ENDPOINT_URL_SQS", sqs_port),
        ("buckets", "name", "AWS_ENDPOINT_URL_S3", s3_port),
        ("topics", "name", "AWS_ENDPOINT_URL_SNS", sns_port),
        ("event_buses", "name", "AWS_ENDPOINT_URL_EVENTS", eb_port),
        ("state_machines", "name", "AWS_ENDPOINT_URL_STEPFUNCTIONS", sf_port),
        ("user_pools", "user_pool_name", "AWS_ENDPOINT_URL_COGNITO_IDP", cognito_port),
    ]
    _TYPE_LABELS = {
        "queues": "Queue",
        "buckets": "Bucket",
        "topics": "Topic",
        "event_buses": "Event Bus",
        "state_machines": "State Machine",
        "user_pools": "User Pool",
    }
    for model_attr, name_attr, env_var, svc_port in _SERVICE_DETAILS:
        items = getattr(app_model, model_attr, [])
        label = _TYPE_LABELS[model_attr]
        for item in items:
            name = getattr(item, name_attr, str(item))
            details[f"{label}:{name}"] = (
                f"http://localhost:{svc_port} | {env_var}"
            )

    return details


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
    )


async def _run_dev(
    project_dir: Path,
    port_override: int | None,
    no_persist: bool,
    force_synth: bool,
    log_level_override: str | None,
) -> None:
    """Async implementation of the ``ldk dev`` command."""
    project_dir = project_dir.resolve()
    config = _load_and_apply_config(project_dir, port_override, no_persist, log_level_override)
    print_banner(__version__, project_dir.name)

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

    # Mount management API
    _mount_management_api(providers, orchestrator, compute_providers, config.port)

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
        await orchestrator.stop()
        typer.echo("Goodbye")


def _create_dynamo_providers(
    app_model: AppModel,
    graph: AppGraph,
    data_dir: Path,
) -> tuple[SqliteDynamoProvider | None, dict[str, Provider]]:
    """Create DynamoDB table providers from the app model."""
    providers: dict[str, Provider] = {}
    table_configs: list[TableConfig] = []
    for table in app_model.tables:
        ks = _build_key_schema(table.key_schema)
        gsi_defs = [_build_gsi(g) for g in table.gsi_definitions]
        table_configs.append(
            TableConfig(table_name=table.name, key_schema=ks, gsi_definitions=gsi_defs)
        )

    if not table_configs:
        return None, providers

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
) -> tuple[SqsProvider | None, dict[str, Provider]]:
    """Create SQS queue providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.queues:
        return None, providers
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
    sqs_provider = SqsProvider(queues=queue_configs)
    for q in app_model.queues:
        node_id = _find_node_id(graph, NodeType.SQS_QUEUE, q.name)
        if node_id:
            providers[node_id] = sqs_provider
    return sqs_provider, providers


def _create_s3_providers(
    app_model: AppModel,
    graph: AppGraph,
    data_dir: Path,
) -> tuple[S3Provider | None, dict[str, Provider]]:
    """Create S3 bucket providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.buckets:
        return None, providers
    bucket_names = [b.name for b in app_model.buckets]
    s3_provider = S3Provider(data_dir=data_dir, buckets=bucket_names)
    for b in app_model.buckets:
        node_id = _find_node_id(graph, NodeType.S3_BUCKET, b.name)
        if node_id:
            providers[node_id] = s3_provider
    return s3_provider, providers


def _create_sns_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[SnsProvider | None, dict[str, Provider]]:
    """Create SNS topic providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.topics:
        return None, providers
    topic_configs = [
        TopicConfig(topic_name=t.name, topic_arn=t.topic_arn) for t in app_model.topics
    ]
    sns_provider = SnsProvider(topics=topic_configs)
    for t in app_model.topics:
        node_id = _find_node_id(graph, NodeType.SNS_TOPIC, t.name)
        if node_id:
            providers[node_id] = sns_provider
    return sns_provider, providers


def _create_eventbridge_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[EventBridgeProvider | None, dict[str, Provider]]:
    """Create EventBridge providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.event_buses and not app_model.event_rules:
        return None, providers
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
    eb_provider = EventBridgeProvider(buses=bus_configs, rules=rule_configs)
    for b in app_model.event_buses:
        node_id = _find_node_id(graph, NodeType.EVENT_BUS, b.name)
        if node_id:
            providers[node_id] = eb_provider
    return eb_provider, providers


def _create_stepfunctions_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[StepFunctionsProvider | None, dict[str, Provider]]:
    """Create Step Functions providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.state_machines:
        return None, providers
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
    sf_provider = StepFunctionsProvider(state_machines=sm_configs)
    for sm in app_model.state_machines:
        node_id = _find_node_id(graph, NodeType.STATE_MACHINE, sm.name)
        if node_id:
            providers[node_id] = sf_provider
    return sf_provider, providers


def _create_ecs_providers(
    app_model: AppModel,
    graph: AppGraph,
) -> tuple[EcsProvider | None, dict[str, Provider]]:
    """Create ECS service providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.ecs_services:
        return None, providers
    ecs_provider = EcsProvider(services=app_model.ecs_services)
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
) -> tuple[CognitoProvider | None, dict[str, Provider]]:
    """Create Cognito user pool providers from the app model."""
    providers: dict[str, Provider] = {}
    if not app_model.user_pools:
        return None, providers
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
    sqs_provider: SqsProvider | None,
    local_endpoints: dict[str, str],
    data_dir: Path,
    api_port: int,
    *,
    sns_port: int,
    eb_port: int,
    sf_port: int,
    cognito_port: int,
) -> tuple[
    SnsProvider | None,
    EventBridgeProvider | None,
    StepFunctionsProvider | None,
    CognitoProvider | None,
]:
    """Wire messaging, cognito, and API Gateway providers."""
    sns_provider, sns_providers = _create_sns_providers(app_model, graph)
    providers.update(sns_providers)
    if sns_provider:
        sns_provider.set_compute_providers(compute_providers)
        if sqs_provider:
            sns_provider.set_queue_provider(sqs_provider)
        local_endpoints["sns"] = f"http://localhost:{sns_port}"

    eb_provider, eb_providers = _create_eventbridge_providers(app_model, graph)
    providers.update(eb_providers)
    if eb_provider:
        eb_provider.set_compute_providers(compute_providers)
        local_endpoints["events"] = f"http://localhost:{eb_port}"

    sf_provider, sf_providers = _create_stepfunctions_providers(app_model, graph)
    providers.update(sf_providers)
    if sf_provider:
        sf_provider.set_compute_providers(compute_providers)
        local_endpoints["stepfunctions"] = f"http://localhost:{sf_port}"

    cognito_provider, cognito_providers = _create_cognito_providers(
        app_model, data_dir, compute_providers
    )
    providers.update(cognito_providers)
    if cognito_provider:
        local_endpoints["cognito-idp"] = f"http://localhost:{cognito_port}"

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
    # +6 Step Functions, +7 Cognito
    dynamo_port = config.port + 1
    sqs_port = config.port + 2
    s3_port = config.port + 3
    sns_port = config.port + 4
    eb_port = config.port + 5
    sf_port = config.port + 6
    cognito_port = config.port + 7

    # 1. Storage providers (no deps)
    dynamo_provider, dynamo_providers = _create_dynamo_providers(app_model, graph, data_dir)
    providers.update(dynamo_providers)

    sqs_provider, sqs_providers = _create_sqs_providers(app_model, graph)
    providers.update(sqs_providers)

    s3_provider, s3_providers = _create_s3_providers(app_model, graph, data_dir)
    providers.update(s3_providers)

    # 2. Build local_endpoints for SDK env redirection
    local_endpoints: dict[str, str] = {}
    if dynamo_provider:
        local_endpoints["dynamodb"] = f"http://localhost:{dynamo_port}"
    if sqs_provider:
        local_endpoints["sqs"] = f"http://localhost:{sqs_port}"
    if s3_provider:
        local_endpoints["s3"] = f"http://localhost:{s3_port}"

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

    # 7. Rebuild SDK env with all service ports and update compute providers
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

    return providers, compute_providers


def _register_http_providers(
    providers: dict[str, Provider],
    *,
    dynamo_provider: SqliteDynamoProvider | None,
    sqs_provider: SqsProvider | None,
    s3_provider: S3Provider | None,
    sns_provider: SnsProvider | None,
    eb_provider: EventBridgeProvider | None,
    sf_provider: StepFunctionsProvider | None,
    cognito_provider: CognitoProvider | None,
    ports: dict[str, int],
) -> None:
    """Register HTTP service providers for each active backend."""
    http_services: list[tuple[str, Any, Callable[[], Any]]] = []
    if dynamo_provider:
        http_services.append(
            ("dynamodb", ports["dynamodb"], lambda p=dynamo_provider: create_dynamodb_app(p))
        )
    if sqs_provider:
        http_services.append(("sqs", ports["sqs"], lambda p=sqs_provider: create_sqs_app(p)))
    if s3_provider:
        http_services.append(("s3", ports["s3"], lambda p=s3_provider: create_s3_app(p)))
    if sns_provider:
        http_services.append(("sns", ports["sns"], lambda p=sns_provider: create_sns_app(p)))
    if eb_provider:
        from ldk.providers.eventbridge.routes import create_eventbridge_app

        http_services.append(
            ("eventbridge", ports["eventbridge"], lambda p=eb_provider: create_eventbridge_app(p))
        )
    if sf_provider:
        from ldk.providers.stepfunctions.routes import create_stepfunctions_app

        http_services.append(
            (
                "stepfunctions",
                ports["stepfunctions"],
                lambda p=sf_provider: create_stepfunctions_app(p),
            )
        )
    if cognito_provider:
        from ldk.providers.cognito.routes import create_cognito_app

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


def _mount_management_api(
    providers: dict[str, Provider],
    orchestrator: Orchestrator,
    compute_providers: dict[str, ICompute],
    port: int,
) -> None:
    """Mount the management API router on the API Gateway app or create a standalone one."""
    from fastapi import FastAPI

    from ldk.api.management import create_management_router

    mgmt_router = create_management_router(orchestrator, compute_providers, providers)

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
