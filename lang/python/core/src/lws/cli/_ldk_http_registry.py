"""HTTP provider registry for the LDK dev server.

Contains the ``_ContainerCleanupProvider`` and ``_HttpServiceProvider``
classes, plus helpers for registering HTTP providers, building resource
metadata, and mounting the management API.
"""

from __future__ import annotations

import asyncio
from collections.abc import Callable
from pathlib import Path
from typing import Any

from lws.interfaces import Provider
from lws.parser.assembly import AppModel
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.aws_operation_fake import AwsFakeConfig
from lws.providers.apigateway.provider import ApiGatewayProvider
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import UserPoolConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app
from lws.providers.eventbridge.provider import EventBridgeProvider
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app
from lws.providers.sns.provider import SnsProvider
from lws.providers.sns.routes import create_sns_app
from lws.providers.sqs.provider import SqsProvider
from lws.providers.sqs.routes import create_sqs_app
from lws.providers.stepfunctions.provider import StepFunctionsProvider
from lws.runtime.orchestrator import Orchestrator


class _CoreProviderSet:
    """Groups the seven core service providers used by ``_register_http_providers``."""

    def __init__(
        self,
        dynamo_provider: SqliteDynamoProvider,
        sqs_provider: SqsProvider,
        s3_provider: S3Provider,
        sns_provider: SnsProvider,
        eb_provider: EventBridgeProvider,
        sf_provider: StepFunctionsProvider,
        cognito_provider: CognitoProvider,
    ) -> None:
        self.dynamo_provider = dynamo_provider
        self.sqs_provider = sqs_provider
        self.s3_provider = s3_provider
        self.sns_provider = sns_provider
        self.eb_provider = eb_provider
        self.sf_provider = sf_provider
        self.cognito_provider = cognito_provider

    @classmethod
    def from_data_dir(cls, data_dir: Path) -> _CoreProviderSet:
        """Create the default core provider set for Terraform mode."""
        pool_config = UserPoolConfig(
            user_pool_id="us-east-1_default",
            user_pool_name="default",
        )
        return cls(
            dynamo_provider=SqliteDynamoProvider(data_dir=data_dir, tables=[]),
            sqs_provider=SqsProvider(),
            s3_provider=S3Provider(data_dir=data_dir),
            sns_provider=SnsProvider(),
            eb_provider=EventBridgeProvider(),
            sf_provider=StepFunctionsProvider(),
            cognito_provider=CognitoProvider(data_dir=data_dir, config=pool_config),
        )


class _ContainerCleanupProvider(Provider):
    """Provider that stops all per-resource containers on shutdown."""

    def __init__(self, managers: list) -> None:
        self._managers = managers

    @property
    def name(self) -> str:
        return "container-cleanup"

    async def start(self) -> None:
        """Nothing to start."""

    async def stop(self) -> None:
        """Stop all per-resource containers."""
        for manager in self._managers:
            await manager.stop_all()

    async def health_check(self) -> bool:
        return True


class _HttpServiceProvider(Provider):
    """Generic wrapper that runs any FastAPI app as a uvicorn-served Provider."""

    def __init__(self, service_name: str, app_factory: Callable[[], Any], port: int) -> None:
        self._service_name = service_name
        self._app_factory = app_factory
        self._port = port
        self._server: Any = None
        self._task: asyncio.Task | None = None  # type: ignore[type-arg]

    @property
    def name(self) -> str:
        return self._service_name

    async def start(self) -> None:
        # pylint: disable=import-outside-toplevel
        from lws.providers.fakeserver.provider import start_uvicorn_server

        result = self._app_factory()
        # Some factories (e.g. create_ssm_app, create_secretsmanager_app) return
        # a (app, state) tuple — extract just the app.
        http_app = result[0] if isinstance(result, tuple) else result
        self._server, self._task = await start_uvicorn_server(http_app, self._port)

    async def stop(self) -> None:
        # pylint: disable=import-outside-toplevel
        from lws.providers.fakeserver.provider import stop_uvicorn_server

        await stop_uvicorn_server(self._server, self._task)
        self._server = None
        self._task = None

    async def health_check(self) -> bool:
        return self._server is not None


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
    chaos_configs: dict[str, Any] | None = None,
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle_configs: dict[str, Any] | None = None,
) -> None:
    """Register HTTP service providers for each active backend."""
    from lws.providers.cognito.routes import (  # pylint: disable=import-outside-toplevel
        create_cognito_app,
    )
    from lws.providers.eventbridge.routes import (  # pylint: disable=import-outside-toplevel
        create_eventbridge_app,
    )
    from lws.providers.stepfunctions.routes import (  # pylint: disable=import-outside-toplevel
        create_stepfunctions_app,
    )

    cc = chaos_configs or {}
    mc = aws_fake_configs or {}
    ia = iam_auth
    lc = lifecycle_configs or {}

    http_services: list[tuple[str, Any, Callable[[], Any]]] = []
    http_services.append(
        (
            "dynamodb",
            ports["dynamodb"],
            lambda p=dynamo_provider, c=cc.get("dynamodb"), m=mc.get(
                "dynamodb"
            ), i=ia: create_dynamodb_app(p, chaos=c, aws_fake=m, iam_auth=i),
        )
    )
    http_services.append(
        (
            "sqs",
            ports["sqs"],
            lambda p=sqs_provider, pt=ports["sqs"], c=cc.get("sqs"), m=mc.get(
                "sqs"
            ), i=ia: create_sqs_app(p, pt, chaos=c, aws_fake=m, iam_auth=i),
        )
    )
    http_services.append(
        (
            "s3",
            ports["s3"],
            lambda p=s3_provider, c=cc.get("s3"), m=mc.get("s3"), i=ia: create_s3_app(
                p, chaos=c, aws_fake=m, iam_auth=i
            ),
        )
    )
    http_services.append(
        (
            "sns",
            ports["sns"],
            lambda p=sns_provider, c=cc.get("sns"), m=mc.get("sns"), i=ia: create_sns_app(
                p, chaos=c, aws_fake=m, iam_auth=i
            ),
        )
    )
    http_services.append(
        (
            "events",
            ports["events"],
            lambda p=eb_provider, c=cc.get("events"), m=mc.get(
                "events"
            ), i=ia: create_eventbridge_app(p, chaos=c, aws_fake=m, iam_auth=i),
        )
    )
    http_services.append(
        (
            "stepfunctions",
            ports["stepfunctions"],
            lambda p=sf_provider, c=cc.get("stepfunctions"), m=mc.get(
                "stepfunctions"
            ), i=ia: create_stepfunctions_app(p, chaos=c, aws_fake=m, iam_auth=i),
        )
    )
    http_services.append(
        (
            "cognito-idp",
            ports["cognito-idp"],
            lambda p=cognito_provider, c=cc.get("cognito-idp"), m=mc.get(
                "cognito-idp"
            ), i=ia, lc_val=lc.get("cognito"): create_cognito_app(
                p, chaos=c, aws_fake=m, iam_auth=i, lifecycle=lc_val
            ),
        )
    )

    for svc_name, port, factory in http_services:
        providers[f"__{svc_name}_http__"] = _HttpServiceProvider(f"{svc_name}-http", factory, port)


def _register_http_providers_from_set(
    providers: dict[str, Provider],
    provider_set: _CoreProviderSet,
    ports: dict[str, int],
    *,
    chaos_configs: dict[str, Any] | None = None,
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle_configs: dict[str, Any] | None = None,
) -> None:
    """Register HTTP service providers from a ``_CoreProviderSet``."""
    _register_http_providers(
        providers,
        dynamo_provider=provider_set.dynamo_provider,
        sqs_provider=provider_set.sqs_provider,
        s3_provider=provider_set.s3_provider,
        sns_provider=provider_set.sns_provider,
        eb_provider=provider_set.eb_provider,
        sf_provider=provider_set.sf_provider,
        cognito_provider=provider_set.cognito_provider,
        ports=ports,
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        iam_auth=iam_auth,
        lifecycle_configs=lifecycle_configs,
    )


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
        "organizations": port + 50,
        "cloudtrail": port + 51,
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


def _mount_management_api(
    providers: dict[str, Provider],
    orchestrator: Orchestrator,
    port: int,
    resource_metadata: dict[str, Any] | None = None,
    chaos_configs: dict[str, AwsChaosConfig] | None = None,
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    iam_auth_bundle: IamAuthBundle | None = None,
    lifecycle_configs: dict[str, Any] | None = None,
) -> None:
    """Mount the management API router on the API Gateway app or create a standalone one."""
    from fastapi import FastAPI  # pylint: disable=import-outside-toplevel

    from lws.api.management import (  # pylint: disable=import-outside-toplevel
        create_management_router,
    )

    mgmt_router = create_management_router(
        orchestrator,
        providers,
        resource_metadata=resource_metadata,
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        iam_auth_bundle=iam_auth_bundle,
        lifecycle_configs=lifecycle_configs,
    )

    # Try to find an existing API Gateway provider to mount on
    for _key, prov in providers.items():
        if isinstance(prov, ApiGatewayProvider):
            prov.app.include_router(mgmt_router)
            return

    # No API Gateway — create a standalone FastAPI app for management
    mgmt_app = FastAPI(title="LDK Management")
    mgmt_app.include_router(mgmt_router)
    providers["__management_http__"] = _HttpServiceProvider(
        "management-http", lambda: mgmt_app, port
    )


def _find_node_id(graph: Any, node_type: Any, name: str) -> str | None:
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


def _build_key_schema(raw_schema: list[dict[str, str]]) -> Any:
    """Convert raw key schema dicts to a KeySchema dataclass."""
    from lws.interfaces import KeyAttribute, KeySchema  # pylint: disable=import-outside-toplevel

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


def _build_gsi(raw_gsi: dict) -> Any:
    """Convert a raw GSI dict to a GsiDefinition dataclass."""
    from lws.interfaces import GsiDefinition  # pylint: disable=import-outside-toplevel

    index_name = raw_gsi.get("index_name", raw_gsi.get("IndexName", "gsi"))
    ks_raw = raw_gsi.get("key_schema", [])
    ks = _build_key_schema(ks_raw)
    projection = raw_gsi.get("projection_type", "ALL")
    return GsiDefinition(index_name=index_name, key_schema=ks, projection_type=projection)
