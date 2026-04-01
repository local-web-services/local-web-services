"""Resource metadata helpers for the LDK dev server management API."""

from __future__ import annotations

from collections.abc import Callable
from typing import Any

from lws.parser.assembly import AppModel


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
        "lambda": port + 9,
        "ssm": port + 12,
        "secretsmanager": port + 13,
        "elasticache": port + 14,
        "memorydb": port + 15,
        "docdb": port + 16,
        "neptune": port + 17,
        "es": port + 18,
        "opensearch": port + 19,
        "rds": port + 20,
        "glacier": port + 21,
        "s3tables": port + 22,
        "cloudtrail": port + 23,
        "organizations": port + 50,
        "cloudformation": port + 51,
        "servicecatalog": port + 52,
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
    _SERVICE_DESCRIPTORS: list[
        tuple[str, str, str | None, Callable[[Any, int | None], dict[str, Any]]]
    ] = [
        (
            "functions",
            "lambda",
            "lambda",
            lambda f, _p: {
                "name": f.name,
                "runtime": f.runtime,
                "arn": f"arn:aws:lambda:us-east-1:000000000000:function:{f.name}",
            },
        ),
        ("tables", "dynamodb", "dynamodb", lambda t, _p: {"name": t.name}),
        (
            "queues",
            "sqs",
            "sqs",
            lambda q, p: {
                "name": q.name,
                "queue_url": f"http://localhost:{p}/000000000000/{q.name}",
            },
        ),
        ("buckets", "s3", "s3", lambda b, _p: {"name": b.name}),
        (
            "topics",
            "sns",
            "sns",
            lambda t, _p: {
                "name": t.name,
                "arn": t.topic_arn or f"arn:aws:sns:us-east-1:000000000000:{t.name}",
            },
        ),
        (
            "event_buses",
            "events",
            "events",
            lambda b, _p: {
                "name": b.name,
                "arn": b.bus_arn or f"arn:aws:events:us-east-1:000000000000:event-bus/{b.name}",
            },
        ),
        (
            "state_machines",
            "stepfunctions",
            "stepfunctions",
            lambda sm, _p: {
                "name": sm.name,
                "arn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{sm.name}",
            },
        ),
        (
            "user_pools",
            "cognito-idp",
            "cognito-idp",
            lambda p, _p2: {
                "name": p.user_pool_name,
                "user_pool_id": f"us-east-1_{p.logical_id}",
            },
        ),
        ("ssm_parameters", "ssm", "ssm", lambda p, _p2: {"name": p.name}),
        (
            "secrets",
            "secretsmanager",
            "secretsmanager",
            lambda s, _p: {
                "name": s.name,
                "arn": f"arn:aws:secretsmanager:us-east-1:000000000000:secret:{s.name}",
            },
        ),
    ]
    for attr, service_key, port_key, resource_fn in _SERVICE_DESCRIPTORS:
        items = getattr(app_model, attr)
        if items:
            port = ports[port_key] if port_key else None
            entry: dict[str, Any] = {
                "resources": [resource_fn(item, port) for item in items],
            }
            if port is not None:
                entry["port"] = port
            services[service_key] = entry
