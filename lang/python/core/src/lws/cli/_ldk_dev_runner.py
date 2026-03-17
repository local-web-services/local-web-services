"""Dev runner helpers for the LDK dev server.

Contains config loading, display helpers, and mode resolution used by
the ``ldk dev`` command.

The actual server startup and async run functions live in ``_ldk_server``.
This module re-exports those symbols so existing callers are unaffected.
"""

from __future__ import annotations

import logging
from pathlib import Path

import typer
from rich.console import Console

# Re-export server-layer symbols so callers importing from this module
# continue to work without changes.
from lws.cli._ldk_server import (  # noqa: F401
    __version__,
    _create_terraform_providers,
    _run_dev,
    _run_dev_terraform,
)
from lws.cli.display import (
    print_error,
    print_resource_summary,
    print_startup_complete,
)
from lws.config.loader import ConfigError, LdkConfig, load_config
from lws.parser.assembly import AppModel

_console = Console()


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


def _build_local_details(
    app_model: AppModel,
    _port: int,
    function_url_ports: dict[str, int] | None = None,
) -> dict[str, str]:
    """Build a mapping of ``"Type:Name"`` to local detail strings."""
    details: dict[str, str] = {}

    _add_api_details(details, app_model, function_url_ports)
    _add_resource_details(details, app_model)
    return details


def _add_api_details(
    details: dict[str, str],
    app_model: AppModel,
    function_url_ports: dict[str, int] | None = None,
) -> None:
    """Add API route and Lambda function details."""
    for api_def in app_model.apis:
        for r in api_def.routes:
            details[f"API Route:{r.path}"] = (
                f"lws apigateway test-invoke-method --resource {r.path} --http-method {r.method}"
            )
    for f in app_model.functions:
        details[f"Function:{f.name}"] = f"lws lambda invoke --function-name {f.name}"
    if function_url_ports:
        for furl in app_model.function_urls:
            port = function_url_ports.get(furl.function_name)
            if port:
                details[f"Function URL:{furl.function_name}"] = f"http://localhost:{port}/"


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
        details[f"State Machine:{sm.name}"] = (
            f"lws stepfunctions start-execution --name {sm.name}"
        )
    for p in app_model.user_pools:
        details[f"User Pool:{p.user_pool_name}"] = (
            f"lws cognito-idp sign-up --user-pool-name {p.user_pool_name}"
        )
    for p in app_model.ssm_parameters:
        details[f"Parameter:{p.name}"] = f"lws ssm get-parameter --name {p.name}"
    for s in app_model.secrets:
        details[f"Secret:{s.name}"] = f"lws secretsmanager get-secret-value --secret-id {s.name}"


def _display_summary(
    app_model: AppModel,
    port: int,
    function_url_ports: dict[str, int] | None = None,
) -> None:
    """Print resource summary and startup-complete banner."""
    routes_info = [
        {"method": r.method, "path": r.path, "handler": r.handler_name or ""}
        for api_def in app_model.apis
        for r in api_def.routes
    ]
    tables_info = [t.name for t in app_model.tables]
    functions_info = [f"{f.name} ({f.runtime})" for f in app_model.functions]

    extra_resources = _collect_extra_resources(app_model)
    local_details = _build_local_details(app_model, port, function_url_ports)
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
    from lws.terraform.detect import detect_project_type  # pylint: disable=import-outside-toplevel

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


def _has_any_resources(app_model: AppModel) -> bool:
    """Return True if the app model contains at least one resource."""
    return any(
        getattr(app_model, attr)
        for attr in (
            "functions",
            "tables",
            "apis",
            "queues",
            "buckets",
            "topics",
            "event_buses",
            "state_machines",
            "ecs_services",
            "user_pools",
            "ssm_parameters",
            "secrets",
            "function_urls",
        )
    )
