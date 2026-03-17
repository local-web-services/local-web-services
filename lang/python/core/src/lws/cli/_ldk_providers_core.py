"""Core-service provider creation helpers for the LDK dev server.

Contains ``_create_*`` functions for the primary AWS services:
DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, ECS, Cognito,
API Gateway, Lambda compute, and Function URLs.
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

from lws.graph.builder import AppGraph, NodeType
from lws.interfaces import (
    ComputeConfig,
    ICompute,
    Provider,
    TableConfig,
)
from lws.parser.assembly import AppModel
from lws.providers.apigateway.provider import ApiGatewayProvider, RouteConfig
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import PasswordPolicy, UserPoolConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.ecs.provider import EcsProvider
from lws.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
)
from lws.providers.lambda_runtime.docker import DockerCompute
from lws.providers.s3.provider import S3Provider
from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sqs.provider import QueueConfig, RedrivePolicy, SqsProvider
from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from lws.runtime.env_builder import build_lambda_env
from lws.runtime.sdk_env import build_sdk_env


def _create_dynamo_providers(
    app_model: AppModel,
    graph: AppGraph,
    data_dir: Path,
) -> tuple[SqliteDynamoProvider, dict[str, Provider]]:
    """Create DynamoDB table providers from the app model.

    Always returns a provider (even with no CDK tables) so the DynamoDB
    HTTP endpoint is available for Terraform/CLI table creation.
    """
    from lws.cli._ldk_http_registry import (  # pylint: disable=import-outside-toplevel
        _build_gsi,
        _build_key_schema,
        _find_node_id,
    )

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
        compute: ICompute = DockerCompute(config=compute_config, sdk_env=sdk_env)
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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

    providers: dict[str, Provider] = {}
    bucket_names = [b.name for b in app_model.buckets]
    s3_provider = S3Provider(data_dir=data_dir, buckets=bucket_names if bucket_names else None)
    for b in app_model.buckets:
        if b.website_configuration:
            s3_provider.put_bucket_website(b.name, b.website_configuration)
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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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
    from lws.cli._ldk_http_registry import _find_node_id  # pylint: disable=import-outside-toplevel

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

    _api_provider, api_providers = _create_api_providers(
        app_model, graph, compute_providers, api_port
    )
    providers.update(api_providers)

    return sns_provider, eb_provider, sf_provider, cognito_provider


def _create_function_url_providers(
    app_model: AppModel,
    base_port: int,
    compute_providers: dict[str, Any],
    providers: dict[str, Provider],
    lambda_registry: Any,
) -> None:
    """Create Function URL providers for each configured URL."""
    from lws.providers.lambda_function_url.provider import (  # pylint: disable=import-outside-toplevel
        LambdaFunctionUrlProvider,
    )

    function_url_base_port = base_port + 23
    for i, furl in enumerate(app_model.function_urls):
        furl_port = function_url_base_port + i
        compute = compute_providers.get(furl.function_name)
        if compute is None:
            continue
        furl_provider = LambdaFunctionUrlProvider(
            function_name=furl.function_name,
            compute=compute,
            port=furl_port,
            cors_config=furl.cors,
        )
        providers[f"__function_url_{furl.function_name}__"] = furl_provider
        url_config = {
            "FunctionName": furl.function_name,
            "FunctionArn": (
                f"arn:aws:lambda:us-east-1:000000000000:function:{furl.function_name}"
            ),
            "AuthType": furl.auth_type,
            "Cors": furl.cors,
            "InvokeMode": furl.invoke_mode,
            "FunctionUrl": f"http://localhost:{furl_port}/",
            "_port": furl_port,
        }
        lambda_registry.register_function_url(furl.function_name, url_config, furl_provider)
