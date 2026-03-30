"""In-process service transport — starts all LWS services within the test process."""

from __future__ import annotations

import socket
from pathlib import Path
from typing import Any

from lws_testing._transport._provider_wrappers import (
    _ApiGatewayStateProvider,
    _CloudTrailStateProvider,
    _ElasticsearchStateProvider,
    _GlacierStateProvider,
    _LambdaRegistryProvider,
    _OpensearchStateProvider,
    _OrganizationsStateProvider,
    _S3TablesStateProvider,
    _SecretsManagerStateProvider,
    _SsmStateProvider,
    _StubOrchestrator,
)


def _free_port() -> int:
    """Return a free ephemeral TCP port on localhost."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def _make_table_config(spec: dict[str, Any]) -> Any:
    """Convert a table spec dict to a TableConfig."""
    from lws.interfaces.key_value_store import KeyAttribute, KeySchema, TableConfig

    pk = KeyAttribute(
        name=spec["partition_key"],
        type=spec.get("partition_key_type", "S"),
    )
    sk = None
    if "sort_key" in spec:
        sk = KeyAttribute(
            name=spec["sort_key"],
            type=spec.get("sort_key_type", "S"),
        )
    return TableConfig(
        table_name=spec["name"],
        key_schema=KeySchema(partition_key=pk, sort_key=sk),
    )


def _make_queue_config(spec: str | dict[str, Any]) -> Any:
    """Convert a queue spec (str or dict) to a QueueConfig."""
    from lws.providers.sqs.provider import QueueConfig

    if isinstance(spec, str):
        return QueueConfig(queue_name=spec)
    return QueueConfig(
        queue_name=spec["name"],
        visibility_timeout=spec.get("visibility_timeout", 30),
        is_fifo=spec.get("is_fifo", False),
        content_based_dedup=spec.get("content_based_dedup", False),
    )


def _make_topic_config(spec: str | dict[str, Any]) -> Any:
    """Convert a topic spec (str or dict) to a TopicConfig."""
    from lws.providers.sns.provider import TopicConfig

    if isinstance(spec, str):
        name = spec
        arn = f"arn:aws:sns:us-east-1:000000000000:{name}"
    else:
        name = spec["name"]
        arn = spec.get("arn", f"arn:aws:sns:us-east-1:000000000000:{name}")
    return TopicConfig(topic_name=name, topic_arn=arn)


def _make_state_machine_config(spec: dict[str, Any]) -> Any:
    """Convert a state machine spec dict to a StateMachineConfig."""
    from lws.providers.stepfunctions.provider import StateMachineConfig

    return StateMachineConfig(
        name=spec["name"],
        definition=spec.get("definition", "{}"),
        role_arn=spec.get("role_arn", ""),
    )


def _make_initial_parameter(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a parameter spec to the dict format expected by create_ssm_app."""
    if isinstance(spec, str):
        return {"name": spec, "value": "", "type": "String"}
    return spec


def _make_initial_secret(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a secret spec to the dict format expected by create_secretsmanager_app."""
    if isinstance(spec, str):
        return {"name": spec, "secret_string": ""}
    return spec


def _create_management_app(
    providers: dict[str, Any],
    chaos_configs: dict[str, Any],
    fake_configs: dict[str, Any],
    lifecycle_configs: dict[str, Any],
    capacity_configs: dict[str, Any] | None = None,
) -> Any:
    """Build a FastAPI management app with reset, fake, chaos, lifecycle, and capacity endpoints."""
    from fastapi import FastAPI
    from fastapi.responses import JSONResponse
    from lws.api.management import _handle_reset, create_management_router

    orchestrator = _StubOrchestrator(providers)
    app = FastAPI(title="LWS Testing Management")

    router = create_management_router(
        orchestrator=orchestrator,
        providers=providers,
        chaos_configs=chaos_configs,
        aws_fake_configs=fake_configs,
        lifecycle_configs=lifecycle_configs,
        capacity_configs=capacity_configs,
    )
    app.include_router(router)

    # Alias endpoint used by LwsSession.reset()
    @app.post("/_ldk/state/clear")
    async def state_clear() -> JSONResponse:
        return await _handle_reset(providers)

    return app


def _setup_logging() -> Any:
    """Initialise WebSocketLogHandler and install it globally."""
    from lws.logging.logger import WebSocketLogHandler, set_ws_handler

    log_handler = WebSocketLogHandler()
    set_ws_handler(log_handler)
    return log_handler


def _convert_spec(spec: dict[str, Any]) -> dict[str, list[Any]]:
    """Convert raw spec dict to typed provider config lists."""
    return {
        "tables": [_make_table_config(t) for t in spec.get("tables", [])],
        "queues": [_make_queue_config(q) for q in spec.get("queues", [])],
        "buckets": [b if isinstance(b, str) else b["name"] for b in spec.get("buckets", [])],
        "topics": [_make_topic_config(t) for t in spec.get("topics", [])],
        "state_machines": [_make_state_machine_config(sm) for sm in spec.get("state_machines", [])],
        "parameters": [_make_initial_parameter(p) for p in spec.get("parameters", [])],
        "secrets": [_make_initial_secret(s) for s in spec.get("secrets", [])],
    }


def _create_providers(cfg: dict[str, list[Any]], data_dir: Path) -> dict[str, Any]:
    """Instantiate all service providers."""
    from lws.providers.cognito._cognito_auth import UserPoolConfig
    from lws.providers.cognito.provider import CognitoProvider
    from lws.providers.dynamodb.provider import SqliteDynamoProvider
    from lws.providers.eventbridge.provider import EventBridgeProvider
    from lws.providers.s3.provider import S3Provider
    from lws.providers.sns.provider import SnsProvider
    from lws.providers.sqs.provider import SqsProvider
    from lws.providers.stepfunctions.provider import StepFunctionsProvider

    for subdir in ("dynamodb", "s3", "cognito"):
        (data_dir / subdir).mkdir(parents=True, exist_ok=True)

    return {
        "dynamodb": SqliteDynamoProvider(data_dir=data_dir / "dynamodb", tables=cfg["tables"]),
        "sqs": SqsProvider(queues=cfg["queues"]),
        "s3": S3Provider(data_dir=data_dir / "s3", buckets=cfg["buckets"]),
        "sns": SnsProvider(topics=cfg["topics"]),
        "stepfunctions": StepFunctionsProvider(state_machines=cfg["state_machines"]),
        "events": EventBridgeProvider(),
        "cognito-idp": CognitoProvider(
            data_dir=data_dir / "cognito",
            config=UserPoolConfig(user_pool_id="us-east-1_e2etest001"),
        ),
    }


def _wire_providers(
    providers: dict[str, Any],
    ssm_state: Any = None,
    secretsmanager_state: Any = None,
    **extra_service_providers: Any,
) -> None:
    """Wire cross-service provider dependencies (SNS→SQS, EventBridge, S3 notifications, SF)."""
    from lws.providers.stepfunctions._service_task_bridge import (
        SecretsManagerStateAdapter,
        SsmStateAdapter,
    )

    sns = providers["sns"]
    sqs = providers["sqs"]
    eb = providers["events"]
    s3 = providers["s3"]
    sf = providers["stepfunctions"]

    sns.set_queue_provider(sqs)
    eb.set_queue_provider(sqs)
    eb.set_sns_provider(sns)
    s3.set_notification_providers(sns_provider=sns, sqs_provider=sqs, events_provider=eb)

    svc: dict[str, Any] = {
        "dynamodb": providers["dynamodb"],
        "sqs": sqs,
        "s3": s3,
        "sns": sns,
        "eventbridge": eb,
    }
    if ssm_state is not None:
        svc["ssm"] = SsmStateAdapter(ssm_state)
    if secretsmanager_state is not None:
        svc["secretsmanager"] = SecretsManagerStateAdapter(secretsmanager_state)
    svc.update({k: v for k, v in extra_service_providers.items() if v is not None})
    sf.set_service_providers(svc)


def _build_service_apps(
    providers: dict[str, Any],
    ports: dict[str, int],
    chaos_configs: dict[str, Any],
    fake_configs: dict[str, Any],
    lifecycle_configs: dict[str, Any],
    cfg: dict[str, list[Any]],
    capacity_configs: dict[str, Any] | None = None,
) -> tuple[list[tuple[str, Any]], dict[str, Any]]:
    """Build FastAPI apps for all services.

    Returns (service_app_pairs, extra_providers_dict).
    """
    from lws.providers.apigateway.routes import create_apigateway_management_app
    from lws.providers.cloudtrail.routes import create_cloudtrail_app
    from lws.providers.dynamodb.routes import create_dynamodb_app
    from lws.providers.eventbridge.routes import create_eventbridge_app
    from lws.providers.organizations.routes import create_organizations_app
    from lws.providers.s3.routes import create_s3_app
    from lws.providers.secretsmanager.routes import create_secretsmanager_app
    from lws.providers.sns.routes import create_sns_app
    from lws.providers.sqs.routes import create_sqs_app
    from lws.providers.ssm.routes import create_ssm_app
    from lws.providers.stepfunctions.routes import create_stepfunctions_app

    from lws_testing._transport._extended_services import build_extended_service_apps

    _cap = capacity_configs or {}
    extended_apps, extended_extra_providers = build_extended_service_apps(
        providers,
        lifecycle_configs,
        capacity_configs=_cap,
        dynamodb_tracker_ref=(_dynamodb_tracker_ref := []),
    )

    ssm_app, ssm_state = create_ssm_app(
        initial_parameters=cfg["parameters"] or None,
        chaos=chaos_configs["ssm"],
        aws_fake=fake_configs["ssm"],
        lifecycle=lifecycle_configs["ssm"],
    )
    secretsmanager_app, secretsmanager_state = create_secretsmanager_app(
        initial_secrets=cfg["secrets"] or None,
        chaos=chaos_configs["secretsmanager"],
        aws_fake=fake_configs["secretsmanager"],
        lifecycle=lifecycle_configs["secretsmanager"],
    )

    service_apps = [
        (
            "dynamodb",
            create_dynamodb_app(
                providers["dynamodb"],
                chaos=chaos_configs["dynamodb"],
                aws_fake=fake_configs["dynamodb"],
                lifecycle=lifecycle_configs["dynamodb"],
                capacity=_cap.get("dynamodb"),
                tracker_ref=_dynamodb_tracker_ref,
            ),
        ),
        (
            "sqs",
            create_sqs_app(
                providers["sqs"],
                port=ports["sqs"],
                chaos=chaos_configs["sqs"],
                aws_fake=fake_configs["sqs"],
                lifecycle=lifecycle_configs["sqs"],
                tracker_ref=(_sqs_tracker_ref := []),
                capacity=_cap.get("sqs"),
            ),
        ),
        (
            "s3",
            create_s3_app(
                providers["s3"],
                chaos=chaos_configs["s3"],
                aws_fake=fake_configs["s3"],
                lifecycle=lifecycle_configs["s3"],
                capacity=_cap.get("s3"),
                sns_provider=providers["sns"],
                sqs_provider=providers["sqs"],
                compute_providers=extended_extra_providers["lambda_registry"].compute,
                tracker_ref=(_s3_tracker_ref := []),
            ),
        ),
        (
            "sns",
            create_sns_app(
                providers["sns"],
                chaos=chaos_configs["sns"],
                aws_fake=fake_configs["sns"],
                lifecycle=lifecycle_configs["sns"],
                sqs_capacity=_cap.get("sqs"),
                sqs_provider=providers["sqs"],
                sqs_tracker=_sqs_tracker_ref[0] if _sqs_tracker_ref else None,
                tracker_ref=(_sns_tracker_ref := []),
            ),
        ),
        (
            "stepfunctions",
            create_stepfunctions_app(
                providers["stepfunctions"],
                chaos=chaos_configs["stepfunctions"],
                aws_fake=fake_configs["stepfunctions"],
                lifecycle=lifecycle_configs["stepfunctions"],
                tracker_ref=(_sf_tracker_ref := []),
                capacity=_cap.get("stepfunctions"),
            ),
        ),
        ("ssm", ssm_app),
        ("secretsmanager", secretsmanager_app),
        (
            "events",
            create_eventbridge_app(
                providers["events"],
                chaos=chaos_configs["events"],
                aws_fake=fake_configs["events"],
                lifecycle=lifecycle_configs["events"],
                sf_tracker=_sf_tracker_ref[0] if _sf_tracker_ref else None,
                sqs_capacity=_cap.get("sqs"),
                sqs_provider=providers["sqs"],
                sqs_tracker=_sqs_tracker_ref[0] if _sqs_tracker_ref else None,
                sns_provider=providers["sns"],
                sns_tracker=_sns_tracker_ref[0] if _sns_tracker_ref else None,
            ),
        ),
        (
            "apigateway",
            (
                _apigateway_app := create_apigateway_management_app(
                    lifecycle=lifecycle_configs["apigateway"],
                    service_providers={
                        k: providers[k] for k in ("dynamodb", "sqs", "s3", "sns", "stepfunctions")
                    },
                )
            )[0],
        ),
        *extended_apps,
    ]

    organizations_app, organizations_state = create_organizations_app(
        chaos=chaos_configs["organizations"],
        aws_fake=fake_configs["organizations"],
    )
    cloudtrail_app, cloudtrail_state = create_cloudtrail_app(
        chaos=chaos_configs["cloudtrail"],
        aws_fake=fake_configs["cloudtrail"],
    )
    service_apps += [("organizations", organizations_app), ("cloudtrail", cloudtrail_app)]

    extra_providers = {
        "ssm": _SsmStateProvider(ssm_state),
        "secretsmanager": _SecretsManagerStateProvider(secretsmanager_state),
        "organizations": _OrganizationsStateProvider(organizations_state),
        "cloudtrail": _CloudTrailStateProvider(cloudtrail_state),
        "lambda": _LambdaRegistryProvider(extended_extra_providers["lambda_registry"]),
        "apigateway-state": _ApiGatewayStateProvider(_apigateway_app[1]),
        "glacier": _GlacierStateProvider(extended_extra_providers["glacier_state"]),
        "s3tables": _S3TablesStateProvider(extended_extra_providers["s3tables_state"]),
        "es": _ElasticsearchStateProvider(extended_extra_providers["elasticsearch_state"]),
        "opensearch-state": _OpensearchStateProvider(extended_extra_providers["opensearch_state"]),
        "_s3_tracker_ref": _s3_tracker_ref,
        "_sns_tracker_ref": _sns_tracker_ref,
    }

    return service_apps, extra_providers


async def _start_all_servers(
    service_apps: list[tuple[str, Any]],
    ports: dict[str, int],
    mgmt_app: Any,
    mgmt_port: int,
) -> list[Any]:
    """Start uvicorn servers for every service app plus the management app."""
    from lws.providers.fakeserver.provider import start_uvicorn_server

    servers: list[Any] = []
    for svc, app in service_apps:
        server, task = await start_uvicorn_server(app, ports[svc], host="127.0.0.1")
        servers.append((server, task))
    mgmt_server, mgmt_task = await start_uvicorn_server(mgmt_app, mgmt_port, host="127.0.0.1")
    servers.append((mgmt_server, mgmt_task))
    return servers


_SERVICE_NAMES = [
    "dynamodb",
    "sqs",
    "s3",
    "sns",
    "stepfunctions",
    "ssm",
    "secretsmanager",
    "events",
    "apigateway",
    "organizations",
    "cloudtrail",
    "cognito-idp",
    "docdb",
    "neptune",
    "rds",
    "elasticache",
    "memorydb",
    "es",
    "opensearch",
    "glacier",
    "s3tables",
    "lambda",
]


async def start_services(
    spec: dict[str, Any],
    data_dir: Path,
) -> tuple[Any, dict[str, int], int, list[Any]]:
    """Start all LWS services in-process.

    Returns (log_handler, service_ports, management_port, servers_list).
    """
    from lws.providers._shared.aws_capacity import AwsCapacityConfig
    from lws.providers._shared.aws_chaos import AwsChaosConfig
    from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
    from lws.providers._shared.aws_operation_fake import AwsFakeConfig

    log_handler = _setup_logging()
    cfg = _convert_spec(spec)
    providers = _create_providers(cfg, data_dir)

    chaos_configs: dict[str, Any] = {s: AwsChaosConfig() for s in _SERVICE_NAMES}
    fake_configs: dict[str, Any] = {s: AwsFakeConfig(service=s) for s in _SERVICE_NAMES}
    lifecycle_configs: dict[str, Any] = {s: ResourceLifecycleConfig() for s in _SERVICE_NAMES}
    capacity_configs: dict[str, Any] = {s: AwsCapacityConfig() for s in _SERVICE_NAMES}
    ports: dict[str, int] = {s: _free_port() for s in _SERVICE_NAMES}
    mgmt_port = _free_port()

    service_apps, extra_providers = _build_service_apps(
        providers,
        ports,
        chaos_configs,
        fake_configs,
        lifecycle_configs,
        cfg,
        capacity_configs,
    )
    # Merge ssm/secretsmanager state wrappers so the management reset endpoint can reach them
    all_providers = {**providers, **extra_providers}

    # Wire cross-service provider dependencies (SNS→SQS, S3 notifications,
    # EventBridge dispatch, StepFunctions service tasks).
    _s3t = extra_providers.get("_s3_tracker_ref", [])
    _snt = extra_providers.get("_sns_tracker_ref", [])
    _wire_providers(
        providers,
        ssm_state=getattr(extra_providers.get("ssm"), "_state", None),
        secretsmanager_state=getattr(extra_providers.get("secretsmanager"), "_state", None),
        s3_tracker=_s3t[0] if _s3t else None,
        sns_tracker=_snt[0] if _snt else None,
        s3_capacity=capacity_configs.get("s3"),
    )

    for provider in providers.values():
        await provider.start()
    mgmt_app = _create_management_app(
        all_providers, chaos_configs, fake_configs, lifecycle_configs, capacity_configs
    )
    servers = await _start_all_servers(service_apps, ports, mgmt_app, mgmt_port)

    return log_handler, ports, mgmt_port, servers


async def stop_services(servers: list[Any]) -> None:
    """Gracefully stop all servers started by :func:`stop_services`."""
    from lws.providers.fakeserver.provider import stop_uvicorn_server

    for server, task in reversed(servers):
        await stop_uvicorn_server(server, task)
