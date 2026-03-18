"""Assembly orchestrator -- top-level entry point for CDK output parsing.

Ties together tree parsing, template parsing, reference resolution and
asset location to produce a single ``AppModel`` that the rest of the
system can consume.
"""

from __future__ import annotations

import json
import logging
from pathlib import Path

from lws.parser._assembly_collectors import (
    collect_event_rules,
    collect_queues,
    collect_state_machines,
    collect_user_pools,
)
from lws.parser._assembly_helpers import (  # pylint: disable=unused-import
    build_resource_map,
    extract_website_configuration,
    find_handler_for_integration,
    resolve_code_path,
    resolve_sm_definition,  # noqa: F401
    resolve_substitutions,  # noqa: F401
)
from lws.parser._assembly_nodes import (
    ApiDefinition,
    ApiRoute,
    AppModel,
    CognitoUserPool,
    DynamoTable,
    EventBus,
    EventRule,
    LambdaFunction,
    LambdaFunctionUrl,
    S3Bucket,
    SmSecret,
    SnsTopic,
    SqsQueue,
    SsmParameter,
    StateMachine,
)
from lws.parser.asset_parser import parse_assets
from lws.parser.ref_resolver import RefResolver
from lws.parser.template_parser import (
    CfnResource,
    extract_api_routes,
    extract_dynamo_tables,
    extract_lambda_functions,
    extract_lambda_urls,
    parse_template,
)
from lws.parser.tree_parser import parse_tree

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Re-exports so existing importers of assembly.py continue to work
# ---------------------------------------------------------------------------
__all__ = [
    "ApiDefinition",
    "ApiRoute",
    "AppModel",
    "CognitoUserPool",
    "DynamoTable",
    "EventBus",
    "EventRule",
    "LambdaFunction",
    "LambdaFunctionUrl",
    "S3Bucket",
    "SmSecret",
    "SnsTopic",
    "SqsQueue",
    "SsmParameter",
    "StateMachine",
    "parse_assembly",
    "_collect_lambda_urls",
]


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

    asset_map = parse_assets(cdk_out_path)

    tree_path = cdk_out_path / "tree.json"
    if tree_path.exists():
        parse_tree(tree_path)

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
    resource_map = build_resource_map(resources)
    resolver = RefResolver(resource_map=resource_map, resource_types=resource_type_map)

    model.functions.extend(_collect_lambdas(resources, asset_map, cdk_out_path, resolver))
    model.tables.extend(_collect_tables(resources, resolver))
    api_def = _collect_api_routes(resources, resolver, artifact_id)
    if api_def:
        model.apis.append(api_def)
    model.queues.extend(collect_queues(resources, resolver))
    model.buckets.extend(_collect_buckets(resources))
    model.topics.extend(_collect_topics(resources, resolver))
    model.event_buses.extend(_collect_event_buses(resources, resolver))
    model.event_rules.extend(collect_event_rules(resources, resolver))
    model.state_machines.extend(collect_state_machines(resources, resolver))
    model.user_pools.extend(collect_user_pools(resources, resolver))
    model.ssm_parameters.extend(_collect_ssm_parameters(resources, resolver))
    model.secrets.extend(_collect_secrets(resources, resolver))
    model.function_urls.extend(_collect_lambda_urls(resources, resolver))

    with open(template_path, encoding="utf-8") as fh:
        raw_template = json.load(fh)
    model.ecs_services.extend(_collect_ecs_services(raw_template))


# ---------------------------------------------------------------------------
# Collector functions
# ---------------------------------------------------------------------------


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
        code_path = resolve_code_path(props.code_uri, asset_map, cdk_out_path, resolver)
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
        handler_name = find_handler_for_integration(
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


def _collect_buckets(resources: list[CfnResource]) -> list[S3Bucket]:
    """Extract S3 buckets from parsed CloudFormation resources."""
    buckets: list[S3Bucket] = []
    for r in resources:
        if r.resource_type != "AWS::S3::Bucket":
            continue
        name = r.properties.get("BucketName", r.logical_id)
        if isinstance(name, dict):
            name = r.logical_id
        website_config = extract_website_configuration(r.properties)
        buckets.append(S3Bucket(name=name, website_configuration=website_config))
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


def _collect_ssm_parameters(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[SsmParameter]:
    """Extract SSM parameters from parsed CloudFormation resources."""
    parameters: list[SsmParameter] = []
    for r in resources:
        if r.resource_type != "AWS::SSM::Parameter":
            continue
        props = r.properties
        name = props.get("Name", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        param_type = props.get("Type", "String")
        value = props.get("Value", "")
        if isinstance(value, dict):
            value = str(resolver.resolve(value))
        description = props.get("Description", "")
        parameters.append(
            SsmParameter(name=name, type=param_type, value=value, description=description)
        )
    return parameters


def _collect_secrets(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[SmSecret]:
    """Extract Secrets Manager secrets from parsed CloudFormation resources."""
    secrets: list[SmSecret] = []
    for r in resources:
        if r.resource_type != "AWS::SecretsManager::Secret":
            continue
        props = r.properties
        name = props.get("Name", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        description = props.get("Description", "")
        secret_string = props.get("SecretString")
        if secret_string is None:
            gen = props.get("GenerateSecretString", {})
            if isinstance(gen, dict):
                secret_string = gen.get("SecretStringTemplate")
        if isinstance(secret_string, dict):
            secret_string = str(resolver.resolve(secret_string))
        secrets.append(SmSecret(name=name, description=description, secret_string=secret_string))
    return secrets


def _collect_lambda_urls(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[LambdaFunctionUrl]:
    """Extract Lambda Function URLs from parsed CloudFormation resources."""
    url_props_list = extract_lambda_urls(resources)
    url_resources = [r for r in resources if r.resource_type == "AWS::Lambda::Url"]
    urls: list[LambdaFunctionUrl] = []
    for r, props in zip(url_resources, url_props_list):
        target = props.target_function_arn
        if isinstance(target, dict):
            target = str(resolver.resolve(target))
        function_name = target or r.logical_id
        if isinstance(function_name, str):
            if function_name.endswith(".Arn"):
                function_name = function_name[:-4]
            if ":function:" in function_name:
                function_name = function_name.rsplit(":", 1)[-1]
        urls.append(
            LambdaFunctionUrl(
                logical_id=r.logical_id,
                function_name=function_name,
                auth_type=props.auth_type,
                cors=props.cors,
                invoke_mode=props.invoke_mode,
            )
        )
    return urls


def _collect_ecs_services(template: dict) -> list:
    """Extract ECS services from the raw CloudFormation template."""
    try:
        from lws.providers.ecs.provider import (  # pylint: disable=import-outside-toplevel
            parse_ecs_resources,
        )

        return parse_ecs_resources(template)
    except Exception:
        logger.debug("Could not parse ECS resources", exc_info=True)
        return []
