"""Assembly orchestrator -- top-level entry point for CDK output parsing.

Ties together tree parsing, template parsing, reference resolution and
asset location to produce a single ``AppModel`` that the rest of the
system can consume.
"""

from __future__ import annotations

import json
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from ldk.parser.asset_parser import parse_assets
from ldk.parser.ref_resolver import RefResolver
from ldk.parser.template_parser import (
    CfnResource,
    extract_api_routes,
    extract_dynamo_tables,
    extract_lambda_functions,
    parse_template,
)
from ldk.parser.tree_parser import parse_tree

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Domain model dataclasses
# ---------------------------------------------------------------------------


@dataclass
class LambdaFunction:
    """Parsed Lambda function ready for local execution."""

    name: str
    handler: str
    runtime: str
    code_path: Path | None = None
    timeout: int = 30
    memory: int = 128
    environment: dict[str, str] = field(default_factory=dict)

    @property
    def logical_id(self) -> str:
        return self.name


@dataclass
class DynamoTable:
    """Parsed DynamoDB table definition."""

    name: str
    key_schema: list[dict[str, str]] = field(default_factory=list)
    gsi_definitions: list[dict[str, Any]] = field(default_factory=list)

    @property
    def logical_id(self) -> str:
        return self.name

    @property
    def table_name(self) -> str:
        return self.name


@dataclass
class ApiRoute:
    """A single API Gateway route."""

    method: str
    path: str
    handler_name: str | None = None


@dataclass
class ApiDefinition:
    """A collection of routes making up an API."""

    name: str = "default"
    routes: list[ApiRoute] = field(default_factory=list)

    @property
    def logical_id(self) -> str:
        return self.name


@dataclass
class SqsQueue:
    """Parsed SQS queue definition."""

    name: str
    is_fifo: bool = False
    visibility_timeout: int = 30
    content_based_dedup: bool = False
    redrive_target: str | None = None
    max_receive_count: int = 5


@dataclass
class S3Bucket:
    """Parsed S3 bucket definition."""

    name: str


@dataclass
class SnsTopic:
    """Parsed SNS topic definition."""

    name: str
    topic_arn: str = ""


@dataclass
class EventBus:
    """Parsed EventBridge event bus definition."""

    name: str
    bus_arn: str = ""


@dataclass
class EventRule:
    """Parsed EventBridge rule definition."""

    rule_name: str
    event_bus_name: str = "default"
    event_pattern: dict[str, Any] | None = None
    schedule_expression: str | None = None
    targets: list[dict[str, Any]] = field(default_factory=list)


@dataclass
class StateMachine:
    """Parsed Step Functions state machine definition."""

    name: str
    definition: str | dict[str, Any] = ""
    workflow_type: str = "STANDARD"
    role_arn: str = ""
    definition_substitutions: dict[str, str] = field(default_factory=dict)


@dataclass
class CognitoUserPool:
    """Parsed Cognito user pool definition."""

    logical_id: str
    user_pool_name: str = "default"
    auto_confirm: bool = True
    password_policy: dict[str, Any] = field(default_factory=dict)
    pre_auth_trigger: str | None = None
    post_confirm_trigger: str | None = None
    client_id: str = ""


@dataclass
class AppModel:
    """Complete parsed representation of a CDK application."""

    functions: list[LambdaFunction] = field(default_factory=list)
    tables: list[DynamoTable] = field(default_factory=list)
    apis: list[ApiDefinition] = field(default_factory=list)
    queues: list[SqsQueue] = field(default_factory=list)
    buckets: list[S3Bucket] = field(default_factory=list)
    topics: list[SnsTopic] = field(default_factory=list)
    event_buses: list[EventBus] = field(default_factory=list)
    event_rules: list[EventRule] = field(default_factory=list)
    state_machines: list[StateMachine] = field(default_factory=list)
    user_pools: list[CognitoUserPool] = field(default_factory=list)
    ecs_services: list[Any] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Orchestrator
# ---------------------------------------------------------------------------


def parse_assembly(cdk_out_path: Path) -> AppModel:
    """Parse an entire CDK ``cdk.out`` directory into an :class:`AppModel`.

    Parameters
    ----------
    cdk_out_path:
        Path to the ``cdk.out`` directory produced by ``cdk synth``.

    Returns
    -------
    AppModel
    """
    manifest_path = cdk_out_path / "manifest.json"
    if not manifest_path.exists():
        logger.warning("No manifest.json found in %s", cdk_out_path)
        return AppModel()

    with open(manifest_path, encoding="utf-8") as fh:
        manifest = json.load(fh)

    # Parse assets (hash -> filesystem path)
    asset_map = parse_assets(cdk_out_path)

    # Parse tree.json if present
    tree_path = cdk_out_path / "tree.json"
    if tree_path.exists():
        parse_tree(tree_path)  # Currently used for validation; future enrichment

    # Collect all stack artifacts
    model = AppModel()
    for artifact_id, artifact in (manifest.get("artifacts") or {}).items():
        if artifact.get("type") != "aws:cloudformation:stack":
            continue
        _process_stack(cdk_out_path, artifact_id, artifact, asset_map, model)

    return model


def _process_stack(
    cdk_out_path: Path,
    artifact_id: str,
    artifact: dict,
    asset_map: dict[str, Path],
    model: AppModel,
) -> None:
    """Process a single CloudFormation stack artifact."""
    template_file = artifact.get("properties", {}).get("templateFile")
    if not template_file:
        logger.warning("Stack %s has no templateFile", artifact_id)
        return

    template_path = cdk_out_path / template_file
    if not template_path.exists():
        logger.warning("Template not found: %s", template_path)
        return

    resources = parse_template(template_path)
    resource_type_map = {r.logical_id: r.resource_type for r in resources}
    resource_map = _build_resource_map(resources)
    resolver = RefResolver(resource_map=resource_map, resource_types=resource_type_map)

    model.functions.extend(_collect_lambdas(resources, asset_map, cdk_out_path, resolver))
    model.tables.extend(_collect_tables(resources, resolver))
    api_def = _collect_api_routes(resources, resolver, artifact_id)
    if api_def:
        model.apis.append(api_def)
    model.queues.extend(_collect_queues(resources, resolver))
    model.buckets.extend(_collect_buckets(resources))
    model.topics.extend(_collect_topics(resources, resolver))
    model.event_buses.extend(_collect_event_buses(resources, resolver))
    model.event_rules.extend(_collect_event_rules(resources, resolver))
    model.state_machines.extend(_collect_state_machines(resources, resolver))
    model.user_pools.extend(_collect_user_pools(resources, resolver))

    # ECS needs the raw template dict
    with open(template_path, encoding="utf-8") as fh:
        raw_template = json.load(fh)
    ecs_services = _collect_ecs_services(raw_template)
    model.ecs_services.extend(ecs_services)


def _build_resource_map(resources: list[CfnResource]) -> dict[str, str]:
    """Build a Ref resource_map so intrinsic ``Ref`` calls resolve to useful local values.

    In real CloudFormation:
    - ``Ref`` on an ``AWS::SQS::Queue`` returns the queue URL.
    - ``Ref`` on an ``AWS::DynamoDB::Table`` returns the table name.

    We reproduce this behaviour with deterministic local placeholders so that
    Lambda environment variables like ``QUEUE_URL`` and ``TABLE_NAME`` resolve
    to values the local providers can understand.
    """
    resource_map: dict[str, str] = {}
    for r in resources:
        if r.resource_type == "AWS::SQS::Queue":
            queue_name = r.properties.get("QueueName", r.logical_id)
            if isinstance(queue_name, str):
                # Use ARN format so the SDK connects via AWS_ENDPOINT_URL_SQS
                # rather than trying to resolve the QueueUrl as a hostname.
                resource_map[r.logical_id] = f"arn:ldk:sqs:local:000000000000:queue/{queue_name}"
        elif r.resource_type == "AWS::DynamoDB::Table":
            # Ref returns the table name.
            table_name = r.properties.get("TableName", r.logical_id)
            if isinstance(table_name, str):
                resource_map[r.logical_id] = table_name
        elif r.resource_type == "AWS::S3::Bucket":
            # Ref returns the bucket name.
            bucket_name = r.properties.get("BucketName", r.logical_id)
            if isinstance(bucket_name, str):
                resource_map[r.logical_id] = bucket_name
            else:
                resource_map[r.logical_id] = r.logical_id
        elif r.resource_type == "AWS::SNS::Topic":
            # Ref returns the topic ARN.
            topic_name = r.properties.get("TopicName", r.logical_id)
            if isinstance(topic_name, str):
                resource_map[r.logical_id] = f"arn:ldk:sns:local:000000000000:{topic_name}"
    return resource_map


def _collect_lambdas(
    resources: list[CfnResource],
    asset_map: dict[str, Path],
    cdk_out_path: Path,
    resolver: RefResolver,
) -> list[LambdaFunction]:
    """Extract Lambda functions from parsed CloudFormation resources."""
    functions: list[LambdaFunction] = []
    lambda_props_list = extract_lambda_functions(resources)
    lambda_resources = [r for r in resources if r.resource_type == "AWS::Lambda::Function"]
    for r, props in zip(lambda_resources, lambda_props_list):
        code_path = _resolve_code_path(props.code_uri, asset_map, cdk_out_path, resolver)
        env = {k: str(resolver.resolve(v)) for k, v in props.environment.items()}
        functions.append(
            LambdaFunction(
                name=r.logical_id,
                handler=props.handler or "index.handler",
                runtime=props.runtime or "python3.11",
                code_path=code_path,
                timeout=props.timeout or 30,
                memory=props.memory_size or 128,
                environment=env,
            )
        )
    return functions


def _collect_tables(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[DynamoTable]:
    """Extract DynamoDB tables from parsed CloudFormation resources."""
    tables: list[DynamoTable] = []
    dynamo_props_list = extract_dynamo_tables(resources)
    dynamo_resources = [r for r in resources if r.resource_type == "AWS::DynamoDB::Table"]
    for r, props in zip(dynamo_resources, dynamo_props_list):
        name = props.table_name or r.logical_id
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        tables.append(
            DynamoTable(
                name=name,
                key_schema=props.key_schema,
                gsi_definitions=props.gsi_definitions,
            )
        )
    return tables


def _collect_api_routes(
    resources: list[CfnResource],
    resolver: RefResolver,
    artifact_id: str,
) -> ApiDefinition | None:
    """Extract API Gateway routes from parsed CloudFormation resources."""
    api_routes = extract_api_routes(resources)
    if not api_routes:
        return None
    routes: list[ApiRoute] = []
    for route_props in api_routes:
        handler_name = _find_handler_for_integration(
            route_props.integration_uri, resources, resolver
        )
        routes.append(
            ApiRoute(
                method=route_props.http_method or "ANY",
                path=route_props.resource_path or "/",
                handler_name=handler_name,
            )
        )
    return ApiDefinition(name=artifact_id, routes=routes)


def _resolve_code_from_s3_key(s3_key: str, asset_map: dict[str, Path]) -> Path | None:
    """Try to match an S3Key to an asset by hash."""
    asset_hash = s3_key.replace(".zip", "")
    if asset_hash in asset_map:
        return asset_map[asset_hash]
    for hash_key, path in asset_map.items():
        if hash_key in s3_key:
            return path
    return None


def _resolve_code_from_s3_bucket(
    s3_bucket: dict, resolver: RefResolver, asset_map: dict[str, Path]
) -> Path | None:
    """Try to match an S3Bucket ref to an asset."""
    resolved = str(resolver.resolve(s3_bucket))
    for h, p in asset_map.items():
        if h in resolved:
            return p
    return None


def _resolve_code_path(
    code_uri: Any,
    asset_map: dict[str, Path],
    cdk_out_path: Path,
    resolver: RefResolver,
) -> Path | None:
    """Resolve a Lambda Code property to a local filesystem path."""
    if code_uri is None:
        return None

    if isinstance(code_uri, dict):
        s3_key = code_uri.get("S3Key")
        if isinstance(s3_key, str):
            result = _resolve_code_from_s3_key(s3_key, asset_map)
            if result:
                return result

        s3_bucket = code_uri.get("S3Bucket")
        if isinstance(s3_bucket, dict):
            result = _resolve_code_from_s3_bucket(s3_bucket, resolver, asset_map)
            if result:
                return result

    if isinstance(code_uri, str):
        candidate = cdk_out_path / code_uri
        if candidate.exists():
            return candidate

    return None


def _find_handler_for_integration(
    integration_uri: Any,
    resources: list[CfnResource],
    resolver: RefResolver,
) -> str | None:
    """Try to match an API integration URI back to a Lambda logical ID."""
    if integration_uri is None:
        return None

    resolved = str(resolver.resolve(integration_uri))

    # Look for a Lambda function logical ID in the resolved string
    for r in resources:
        if r.resource_type == "AWS::Lambda::Function":
            if r.logical_id in resolved:
                return r.logical_id

    return None


# ---------------------------------------------------------------------------
# Collectors for new resource types
# ---------------------------------------------------------------------------


def _collect_queues(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[SqsQueue]:
    """Extract SQS queues from parsed CloudFormation resources."""
    queues: list[SqsQueue] = []
    for r in resources:
        if r.resource_type != "AWS::SQS::Queue":
            continue
        props = r.properties
        name = props.get("QueueName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        is_fifo = bool(props.get("FifoQueue", False))
        vis = int(props.get("VisibilityTimeout", 30))
        dedup = bool(props.get("ContentBasedDeduplication", False))
        redrive = props.get("RedrivePolicy")
        redrive_target = None
        max_receive = 5
        if isinstance(redrive, dict):
            dlq = redrive.get("deadLetterTargetArn", "")
            if isinstance(dlq, dict):
                dlq = str(resolver.resolve(dlq))
            redrive_target = str(dlq) if dlq else None
            max_receive = int(redrive.get("maxReceiveCount", 5))
        queues.append(
            SqsQueue(
                name=name,
                is_fifo=is_fifo,
                visibility_timeout=vis,
                content_based_dedup=dedup,
                redrive_target=redrive_target,
                max_receive_count=max_receive,
            )
        )
    return queues


def _collect_buckets(resources: list[CfnResource]) -> list[S3Bucket]:
    """Extract S3 buckets from parsed CloudFormation resources."""
    buckets: list[S3Bucket] = []
    for r in resources:
        if r.resource_type != "AWS::S3::Bucket":
            continue
        name = r.properties.get("BucketName", r.logical_id)
        if isinstance(name, dict):
            name = r.logical_id  # Can't resolve intrinsics for bucket names easily
        buckets.append(S3Bucket(name=name))
    return buckets


def _collect_topics(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[SnsTopic]:
    """Extract SNS topics from parsed CloudFormation resources."""
    topics: list[SnsTopic] = []
    for r in resources:
        if r.resource_type != "AWS::SNS::Topic":
            continue
        props = r.properties
        name = props.get("TopicName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        arn = f"arn:aws:sns:us-east-1:000000000000:{name}"
        topics.append(SnsTopic(name=name, topic_arn=arn))
    return topics


def _collect_event_buses(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[EventBus]:
    """Extract EventBridge event buses from parsed CloudFormation resources."""
    buses: list[EventBus] = []
    for r in resources:
        if r.resource_type != "AWS::Events::EventBus":
            continue
        props = r.properties
        name = props.get("Name", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        arn = f"arn:aws:events:us-east-1:000000000000:event-bus/{name}"
        buses.append(EventBus(name=name, bus_arn=arn))
    return buses


def _collect_event_rules(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[EventRule]:
    """Extract EventBridge rules from parsed CloudFormation resources."""
    rules: list[EventRule] = []
    for r in resources:
        if r.resource_type != "AWS::Events::Rule":
            continue
        props = r.properties
        rule_name = props.get("Name", r.logical_id)
        if isinstance(rule_name, dict):
            rule_name = str(resolver.resolve(rule_name))
        bus_name = props.get("EventBusName", "default")
        if isinstance(bus_name, dict):
            bus_name = str(resolver.resolve(bus_name))
        pattern = props.get("EventPattern")
        schedule = props.get("ScheduleExpression")
        raw_targets = props.get("Targets", [])
        targets: list[dict[str, Any]] = []
        for t in raw_targets:
            target_arn = t.get("Arn", "")
            if isinstance(target_arn, dict):
                target_arn = str(resolver.resolve(target_arn))
            targets.append(
                {
                    "target_id": t.get("Id", ""),
                    "arn": target_arn,
                    "input_path": t.get("InputPath"),
                    "input_template": t.get("InputTransformer", {}).get("InputTemplate"),
                }
            )
        rules.append(
            EventRule(
                rule_name=rule_name,
                event_bus_name=bus_name,
                event_pattern=pattern,
                schedule_expression=schedule,
                targets=targets,
            )
        )
    return rules


def _resolve_sm_definition(definition: Any, resolver: RefResolver) -> Any:
    """Resolve a Step Functions DefinitionString that may use intrinsic functions."""
    if isinstance(definition, dict):
        return resolver.resolve(definition)
    return definition


def _resolve_substitutions(subs: dict[str, Any], resolver: RefResolver) -> dict[str, str]:
    """Resolve CloudFormation DefinitionSubstitutions to plain strings."""
    return {k: str(resolver.resolve(v)) if isinstance(v, dict) else str(v) for k, v in subs.items()}


def _collect_state_machines(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[StateMachine]:
    """Extract Step Functions state machines from parsed CloudFormation resources."""
    machines: list[StateMachine] = []
    for r in resources:
        if r.resource_type != "AWS::StepFunctions::StateMachine":
            continue
        props = r.properties
        name = props.get("StateMachineName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        definition = props.get("DefinitionString", props.get("Definition", ""))
        definition = _resolve_sm_definition(definition, resolver)
        role_arn = props.get("RoleArn", "")
        if isinstance(role_arn, dict):
            role_arn = str(resolver.resolve(role_arn))
        resolved_subs = _resolve_substitutions(props.get("DefinitionSubstitutions", {}), resolver)
        machines.append(
            StateMachine(
                name=name,
                definition=definition,
                workflow_type=props.get("StateMachineType", "STANDARD"),
                role_arn=role_arn,
                definition_substitutions=resolved_subs,
            )
        )
    return machines


def _collect_user_pools(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[CognitoUserPool]:
    """Extract Cognito user pools from parsed CloudFormation resources."""
    pools: list[CognitoUserPool] = []
    # First pass: collect user pool clients to map pool -> client_id
    client_map: dict[str, str] = {}
    for r in resources:
        if r.resource_type != "AWS::Cognito::UserPoolClient":
            continue
        pool_ref = r.properties.get("UserPoolId", "")
        if isinstance(pool_ref, dict):
            pool_ref = str(resolver.resolve(pool_ref))
        client_map[pool_ref] = r.logical_id

    for r in resources:
        if r.resource_type != "AWS::Cognito::UserPool":
            continue
        props = r.properties
        name = props.get("UserPoolName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        auto_confirm = True
        lambda_config = props.get("LambdaConfig", {})
        pre_auth = lambda_config.get("PreAuthentication")
        if isinstance(pre_auth, dict):
            pre_auth = str(resolver.resolve(pre_auth))
        post_confirm = lambda_config.get("PostConfirmation")
        if isinstance(post_confirm, dict):
            post_confirm = str(resolver.resolve(post_confirm))
        pw_policy = props.get("Policies", {}).get("PasswordPolicy", {})
        client_id = client_map.get(r.logical_id, "")
        pools.append(
            CognitoUserPool(
                logical_id=r.logical_id,
                user_pool_name=name,
                auto_confirm=auto_confirm,
                password_policy=pw_policy,
                pre_auth_trigger=pre_auth,
                post_confirm_trigger=post_confirm,
                client_id=client_id,
            )
        )
    return pools


def _collect_ecs_services(template: dict) -> list:
    """Extract ECS services from the raw CloudFormation template."""
    try:
        from ldk.providers.ecs.provider import parse_ecs_resources

        return parse_ecs_resources(template)
    except Exception:
        logger.debug("Could not parse ECS resources", exc_info=True)
        return []
