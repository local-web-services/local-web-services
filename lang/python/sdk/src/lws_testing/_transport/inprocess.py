"""In-process service transport — starts all LWS services within the test process."""

from __future__ import annotations

import socket
from pathlib import Path
from typing import Any

from lws.providers._shared.async_state_store import AsyncStateStore

from lws_testing._transport._management_app import _create_management_app
from lws_testing._transport._provider_wrappers import (
    _ApiGatewayStateProvider,
    _ClusterDBStateProvider,
    _ElasticsearchStateProvider,
    _GlacierStateProvider,
    _LambdaRegistryProvider,
    _OpensearchStateProvider,
    _OrganizationsStateProvider,
    _S3TablesStateProvider,
    _SecretsManagerStateProvider,
    _SsmStateProvider,
)
from lws_testing._transport._spec_converters import convert_spec


def _bound_socket() -> socket.socket:
    """Bind a socket to an OS-assigned port and return it (kept open).

    Keeping the socket open prevents other processes from claiming the same
    port between the ``bind`` call and the moment uvicorn starts listening —
    the TOCTOU race that causes ``[Errno 48] address already in use`` when
    many test processes start in parallel.
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(("127.0.0.1", 0))
    return sock


def _unbox(ref: list[Any]) -> Any | None:
    """Return ref[0] if non-empty, else None."""
    return ref[0] if ref else None


def _setup_logging() -> Any:
    """Initialise WebSocketLogHandler and install it globally."""
    from lws.logging.logger import WebSocketLogHandler, set_ws_handler

    log_handler = WebSocketLogHandler()
    set_ws_handler(log_handler)
    return log_handler


def _create_providers(cfg: dict[str, list[Any]], data_dir: Path) -> dict[str, Any]:
    """Instantiate all service providers."""
    from lws.providers.cloudtrail.provider import CloudTrailProvider
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
        "cloudtrail": CloudTrailProvider(),
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

    ct = providers.get("cloudtrail")
    if ct is not None:
        ct.set_s3_provider(s3)
        ct.set_eventbridge_provider(eb)

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
    tracker_registry: dict | None = None,
) -> tuple[list[tuple[str, Any]], dict[str, Any]]:
    """Build FastAPI apps for all services.

    Returns a tuple of:
    - list of (service_name, app) pairs for server startup
    - dict of extra providers (ssm, secretsmanager state wrappers) for reset support
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
    _ct = providers.get("cloudtrail")
    extended_apps, extended_extra_providers = build_extended_service_apps(
        providers,
        lifecycle_configs,
        capacity_configs=_cap,
        dynamodb_tracker_ref=(_dynamodb_tracker_ref := []),
        tracker_registry=tracker_registry,
        cloudtrail_provider=_ct,
    )

    ssm_app, ssm_state = create_ssm_app(
        initial_parameters=cfg["parameters"] or None,
        chaos=chaos_configs["ssm"],
        aws_fake=fake_configs["ssm"],
        lifecycle=lifecycle_configs["ssm"],
        cloudtrail_provider=_ct,
    )
    secretsmanager_app, secretsmanager_state = create_secretsmanager_app(
        initial_secrets=cfg["secrets"] or None,
        chaos=chaos_configs["secretsmanager"],
        aws_fake=fake_configs["secretsmanager"],
        lifecycle=lifecycle_configs["secretsmanager"],
        cloudtrail_provider=_ct,
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
                cloudtrail_provider=_ct,
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
                cloudtrail_provider=_ct,
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
                cloudtrail_provider=_ct,
            ),
        ),
        (
            "sns",
            create_sns_app(
                providers["sns"],
                chaos=chaos_configs["sns"],
                aws_fake=fake_configs["sns"],
                lifecycle=lifecycle_configs["sns"],
                sns_capacity=_cap.get("sns"),
                sqs_capacity=_cap.get("sqs"),
                sqs_provider=providers["sqs"],
                sqs_tracker=_unbox(_sqs_tracker_ref),
                tracker_ref=(_sns_tracker_ref := []),
                cloudtrail_provider=_ct,
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
                sqs_provider=providers["sqs"],
                sqs_tracker=_unbox(_sqs_tracker_ref),
                cloudtrail_provider=_ct,
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
                sf_tracker=_unbox(_sf_tracker_ref),
                sqs_capacity=_cap.get("sqs"),
                sqs_provider=providers["sqs"],
                sqs_tracker=_unbox(_sqs_tracker_ref),
                sns_provider=providers["sns"],
                sns_tracker=_unbox(_sns_tracker_ref),
                lambda_registry=extended_extra_providers["lambda_registry"],
                lambda_tracker=extended_extra_providers.get("lambda_tracker"),
                dynamodb_provider=providers["dynamodb"],
                dynamodb_tracker=_unbox(_dynamodb_tracker_ref),
                cloudtrail_provider=_ct,
            ),
        ),
        (
            "cloudtrail",
            create_cloudtrail_app(
                providers["cloudtrail"],
                chaos=chaos_configs["cloudtrail"],
                aws_fake=fake_configs["cloudtrail"],
            ),
        ),
        (
            "apigateway",
            (
                _apigateway_app := create_apigateway_management_app(
                    lifecycle=lifecycle_configs["apigateway"],
                    service_providers={
                        **{
                            k: providers[k]
                            for k in ("dynamodb", "sqs", "s3", "sns", "stepfunctions")
                        },
                        "dynamodb_tracker": _unbox(_dynamodb_tracker_ref),
                        "dynamodb_capacity": _cap.get("dynamodb"),
                        "sqs_tracker": _unbox(_sqs_tracker_ref),
                        "sqs_capacity": _cap.get("sqs"),
                        "s3_tracker": _unbox(_s3_tracker_ref),
                        "sns_tracker": _unbox(_sns_tracker_ref),
                        "sns_capacity": _cap.get("sns"),
                        "stepfunctions_tracker": _unbox(_sf_tracker_ref),
                        "stepfunctions_capacity": _cap.get("stepfunctions"),
                    },
                    capacity=_cap.get("apigateway"),
                )
            )[0],
        ),
        *extended_apps,
    ]

    organizations_app, organizations_state = create_organizations_app(
        chaos=chaos_configs["organizations"],
        aws_fake=fake_configs["organizations"],
        cloudtrail_provider=_ct,
    )
    service_apps.append(("organizations", organizations_app))

    extra_providers = {
        "ssm": _SsmStateProvider(ssm_state),
        "secretsmanager": _SecretsManagerStateProvider(secretsmanager_state),
        "organizations": _OrganizationsStateProvider(organizations_state),
        "lambda": _LambdaRegistryProvider(extended_extra_providers["lambda_registry"]),
        "apigateway-state": _ApiGatewayStateProvider(_apigateway_app[1]),
        "glacier": _GlacierStateProvider(extended_extra_providers["glacier_state"]),
        "s3tables": _S3TablesStateProvider(extended_extra_providers["s3tables_state"]),
        "es": _ElasticsearchStateProvider(extended_extra_providers["elasticsearch_state"]),
        "opensearch-state": _OpensearchStateProvider(extended_extra_providers["opensearch_state"]),
        "neptune-state": _ClusterDBStateProvider(
            extended_extra_providers["neptune_state"], "neptune"
        ),
        "docdb-state": _ClusterDBStateProvider(extended_extra_providers["docdb_state"], "docdb"),
        "_s3_tracker_ref": _s3_tracker_ref,
        "_sns_tracker_ref": _sns_tracker_ref,
    }

    return service_apps, extra_providers


async def _start_all_servers(
    service_apps: list[tuple[str, Any]],
    sockets: dict[str, socket.socket],
    mgmt_app: Any,
    mgmt_socket: socket.socket,
) -> list[Any]:
    """Start uvicorn servers for every service app plus the management app."""
    from lws.providers.fakeserver.provider import start_uvicorn_server

    servers: list[Any] = []
    for svc, app in service_apps:
        server, task = await start_uvicorn_server(app, sockets[svc], host="127.0.0.1")
        servers.append((server, task))
    mgmt_server, mgmt_task = await start_uvicorn_server(mgmt_app, mgmt_socket, host="127.0.0.1")
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

    Returns:
        Tuple of (log_handler, service_ports, management_port, servers_list).
        ``servers_list`` is a list of ``(Server, Task)`` pairs that can be
        passed directly to :func:`stop_services`.
    """
    from lws.providers._shared.aws_capacity import AwsCapacityConfig
    from lws.providers._shared.aws_chaos import AwsChaosConfig
    from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, TrackerRegistry
    from lws.providers._shared.aws_operation_fake import AwsFakeConfig
    from lws.providers.fakeserver.provider import FakeServerProvider

    log_handler = _setup_logging()
    cfg = convert_spec(spec)
    providers = _create_providers(cfg, data_dir)
    fake_server_provider = FakeServerProvider(project_dir=data_dir, base_port=14000)

    chaos_configs: dict[str, Any] = {s: AwsChaosConfig() for s in _SERVICE_NAMES}
    fake_configs: dict[str, Any] = {s: AwsFakeConfig(service=s) for s in _SERVICE_NAMES}
    lifecycle_configs: dict[str, Any] = {s: ResourceLifecycleConfig() for s in _SERVICE_NAMES}
    capacity_configs: dict[str, Any] = {s: AwsCapacityConfig() for s in _SERVICE_NAMES}
    capacity_configs["lambda-async"] = AwsCapacityConfig()
    tracker_registry: TrackerRegistry = {}
    _sockets: dict[str, socket.socket] = {s: _bound_socket() for s in _SERVICE_NAMES}
    _mgmt_socket = _bound_socket()
    ports: dict[str, int] = {s: sock.getsockname()[1] for s, sock in _sockets.items()}
    mgmt_port = _mgmt_socket.getsockname()[1]

    service_apps, extra_providers = _build_service_apps(
        providers,
        ports,
        chaos_configs,
        fake_configs,
        lifecycle_configs,
        cfg,
        capacity_configs,
        tracker_registry=tracker_registry,
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

    state_store = AsyncStateStore()
    for provider in providers.values():
        await provider.start()
    await fake_server_provider.start()
    all_providers["__fake_server__"] = fake_server_provider
    mgmt_app = _create_management_app(
        all_providers,
        chaos_configs,
        fake_configs,
        lifecycle_configs,
        capacity_configs,
        fake_provider=fake_server_provider,
        state_store=state_store,
        tracker_registry=tracker_registry,
    )
    servers = await _start_all_servers(service_apps, _sockets, mgmt_app, _mgmt_socket)

    return log_handler, ports, mgmt_port, servers, providers


async def stop_services(servers: list[Any], providers: dict[str, Any] | None = None) -> None:
    """Gracefully stop all servers started by :func:`start_services`."""
    from lws.providers.fakeserver.provider import stop_uvicorn_server

    for server, task in reversed(servers):
        await stop_uvicorn_server(server, task)

    for provider in (providers or {}).values():
        if hasattr(provider, "stop"):
            await provider.stop()
