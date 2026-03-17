"""Provider factory helpers for the LDK dev server.

Contains the top-level ``_create_providers()`` orchestration function, plus the
shared config-creation helpers used across CDK and Terraform modes.

Per-service creation logic lives in:
- ``_ldk_providers_core`` — DynamoDB, SQS, S3, SNS, EventBridge, Step
  Functions, ECS, Cognito, Lambda compute, API Gateway, Function URLs
- ``_ldk_providers_extended`` — SSM, Secrets Manager, and experimental
  services (ElastiCache, MemoryDB, DocumentDB, Neptune, Elasticsearch,
  OpenSearch, RDS, Glacier, S3 Tables)
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

# Re-export per-service helpers so existing callers importing from this
# module continue to work without changes.
from lws.cli._ldk_providers_core import (  # noqa: F401
    _create_api_providers,
    _create_cognito_providers,
    _create_compute_providers,
    _create_dynamo_providers,
    _create_ecs_providers,
    _create_eventbridge_providers,
    _create_function_url_providers,
    _create_s3_providers,
    _create_sns_providers,
    _create_sqs_providers,
    _create_stepfunctions_providers,
    _wire_remaining_providers,
)
from lws.cli._ldk_providers_extended import (  # noqa: F401
    _register_experimental_providers,
    _register_ssm_secretsmanager_providers,
)
from lws.config.loader import LdkConfig
from lws.graph.builder import AppGraph
from lws.interfaces import Provider
from lws.parser.assembly import AppModel
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.providers._shared.aws_iam_auth import IamAuthBundle
from lws.providers._shared.aws_operation_fake import AwsFakeConfig

_CHAOS_SERVICES = [
    "dynamodb",
    "sqs",
    "s3",
    "sns",
    "events",
    "stepfunctions",
    "cognito-idp",
    "ssm",
    "secretsmanager",
    "iam",
]

_LIFECYCLE_SERVICES = [
    "sns",
    "cognito",
]


def _create_chaos_configs() -> dict[str, AwsChaosConfig]:
    """Create a default (disabled) AwsChaosConfig for each service."""
    return {svc: AwsChaosConfig() for svc in _CHAOS_SERVICES}


def _create_lifecycle_configs() -> dict[str, Any]:
    """Create a default (disabled) ResourceLifecycleConfig for each lifecycle-capable service."""
    from lws.providers._shared.aws_lifecycle import (  # pylint: disable=import-outside-toplevel
        ResourceLifecycleConfig,
    )

    return {svc: ResourceLifecycleConfig() for svc in _LIFECYCLE_SERVICES}


def _load_aws_fake_configs(project_dir: Path | None) -> dict[str, AwsFakeConfig]:
    """Load AWS fake configs, defaulting to disabled for every service.

    Like chaos configs, a default disabled ``AwsFakeConfig`` is created for
    every supported service so the middleware is always mounted and rules
    can be added at runtime via the management API.
    """
    configs: dict[str, AwsFakeConfig] = {
        svc: AwsFakeConfig(service=svc, enabled=False) for svc in _CHAOS_SERVICES
    }
    if project_dir is not None:
        from lws.providers._shared.aws_fake_registry import (  # pylint: disable=import-outside-toplevel
            AwsFakeRegistry,
        )

        fakes_dir = project_dir / ".lws" / "fakes"
        file_configs = AwsFakeRegistry(fakes_dir).load_all()
        configs.update(file_configs)
    return configs


def _create_iam_auth_bundle(
    config: LdkConfig,
    project_dir: Path | None = None,
) -> IamAuthBundle:
    """Create an IamAuthBundle from config."""
    from lws.providers._shared.iam_identity_store import (  # pylint: disable=import-outside-toplevel
        IdentityStore,
    )
    from lws.providers._shared.iam_permissions_map import (  # pylint: disable=import-outside-toplevel
        PermissionsMap,
    )
    from lws.providers._shared.iam_resource_policies import (  # pylint: disable=import-outside-toplevel
        ResourcePolicyStore,
    )

    iam_config = config.iam_auth

    iam_dir = Path(project_dir / config.data_dir / "iam") if project_dir else None
    identities_path = iam_dir / "identities.yaml" if iam_dir else None
    permissions_path = iam_dir / "permissions.yaml" if iam_dir else None
    resource_policies_path = iam_dir / "resource_policies.yaml" if iam_dir else None

    return IamAuthBundle(
        config=iam_config,
        identity_store=IdentityStore(identities_path),
        permissions_map=PermissionsMap(permissions_path),
        resource_policy_store=ResourcePolicyStore(resource_policies_path),
    )


def _register_fake_provider(
    providers: dict[str, Provider],
    base_port: int,
    project_dir: Path | None = None,
) -> None:
    """Register the FakeServerProvider if .lws/fakes/ exists."""
    if project_dir is None:
        return
    fakes_dir = project_dir / ".lws" / "fakes"
    if not fakes_dir.exists():
        return

    from lws.providers.fakeserver.provider import (  # pylint: disable=import-outside-toplevel
        FakeServerProvider,
    )

    fake_port = base_port + 100
    fake_provider = FakeServerProvider(project_dir, base_port=fake_port)
    providers["__fake_server__"] = fake_provider


def _create_providers(
    app_model: AppModel,
    graph: AppGraph,
    config: LdkConfig,
    data_dir: Path,
    iam_auth_bundle: IamAuthBundle | None = None,
) -> tuple[
    dict[str, Provider], dict[str, AwsChaosConfig], dict[str, AwsFakeConfig], dict[str, Any]
]:
    """Instantiate providers from the parsed app model.

    Returns a provider map (including the Lambda HTTP server on port+9)
    and a chaos config map for runtime updates.
    """
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _HttpServiceProvider,
        _register_http_providers,
    )
    from lws.runtime.sdk_env import build_sdk_env  # pylint: disable=import-outside-toplevel

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
    _ecs_provider, ecs_providers = _create_ecs_providers(app_model, graph)
    providers.update(ecs_providers)

    # 7. Create LambdaRegistry and register CDK functions
    from lws.providers.lambda_runtime.routes import (  # pylint: disable=import-outside-toplevel
        LambdaRegistry,
        create_lambda_management_app,
    )

    lambda_port = config.port + 9
    lambda_registry = LambdaRegistry()

    for func in app_model.functions:
        func_config = {
            "FunctionName": func.name,
            "Runtime": func.runtime,
            "Handler": func.handler,
            "Timeout": func.timeout,
            "MemorySize": func.memory,
            "Environment": {"Variables": func.environment},
        }
        lambda_registry.register(func.name, func_config, compute_providers[func.name])

    # 8. Add SSM and Secrets Manager endpoints, rebuild SDK env, update compute
    local_endpoints["ssm"] = f"http://127.0.0.1:{ssm_port}"
    local_endpoints["secretsmanager"] = f"http://127.0.0.1:{secretsmanager_port}"
    sdk_env = build_sdk_env(local_endpoints)
    for compute in lambda_registry.compute.values():
        if hasattr(compute, "sdk_env"):
            compute.sdk_env = sdk_env

    # 9. Lambda management HTTP server on port+9
    providers["__lambda_http__"] = _HttpServiceProvider(
        "lambda-http",
        lambda: create_lambda_management_app(lambda_registry, None, sdk_env),
        lambda_port,
    )

    # 9b. Function URL providers
    _create_function_url_providers(
        app_model, config.port, compute_providers, providers, lambda_registry
    )

    # 10. Create HTTP servers for each active service
    chaos_configs = _create_chaos_configs()
    aws_fake_configs = _load_aws_fake_configs(data_dir.parent)
    lifecycle_configs = _create_lifecycle_configs()
    if iam_auth_bundle is None:
        iam_auth_bundle = _create_iam_auth_bundle(config, data_dir.parent)

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
            "events": eb_port,
            "stepfunctions": sf_port,
            "cognito-idp": cognito_port,
        },
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        iam_auth=iam_auth_bundle,
        lifecycle_configs=lifecycle_configs,
    )

    # 11. SSM Parameter Store and Secrets Manager (pre-seeded from CloudFormation)
    _register_ssm_secretsmanager_providers(
        providers,
        app_model=app_model,
        chaos_configs=chaos_configs,
        aws_fake_configs=aws_fake_configs,
        iam_auth_bundle=iam_auth_bundle,
        ssm_port=ssm_port,
        secretsmanager_port=secretsmanager_port,
    )

    # Fake server provider
    _register_fake_provider(providers, config.port, data_dir.parent)

    return providers, chaos_configs, aws_fake_configs, lifecycle_configs
