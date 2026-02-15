"""Parser for AWS CloudFormation / CDK-synthesised templates.

Extracts typed resource descriptors for Lambda functions, DynamoDB tables,
and API Gateway routes from a CloudFormation JSON template.
"""

from __future__ import annotations

import json
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Generic CFN resource
# ---------------------------------------------------------------------------


@dataclass
class CfnResource:
    """A single CloudFormation resource entry."""

    logical_id: str
    resource_type: str
    properties: dict[str, Any]


# ---------------------------------------------------------------------------
# Typed property dataclasses
# ---------------------------------------------------------------------------


@dataclass
class LambdaFunctionProps:
    """Subset of ``AWS::Lambda::Function`` properties we care about."""

    handler: str | None = None
    runtime: str | None = None
    code_uri: Any | None = None
    timeout: int | None = None
    memory_size: int | None = None
    environment: dict[str, str] = field(default_factory=dict)


@dataclass
class DynamoTableProps:
    """Subset of ``AWS::DynamoDB::Table`` properties."""

    table_name: str | None = None
    key_schema: list[dict[str, str]] = field(default_factory=list)
    attribute_definitions: list[dict[str, str]] = field(default_factory=list)
    gsi_definitions: list[dict[str, Any]] = field(default_factory=list)


@dataclass
class EventSourceMappingProps:
    """Subset of ``AWS::Lambda::EventSourceMapping`` properties."""

    function_name: Any = None
    event_source_arn: Any = None
    batch_size: int = 10
    enabled: bool = True


@dataclass
class ApiGatewayRouteProps:
    """A single API Gateway route (v1 or v2)."""

    http_method: str | None = None
    resource_path: str | None = None
    integration_uri: Any | None = None


# ---------------------------------------------------------------------------
# Template parsing
# ---------------------------------------------------------------------------


def parse_template(template_path: Path) -> list[CfnResource]:
    """Load a CloudFormation JSON template and return all resources.

    Parameters
    ----------
    template_path:
        Path to the ``*.template.json`` file.

    Returns
    -------
    list[CfnResource]
    """
    with open(template_path, encoding="utf-8") as fh:
        data = json.load(fh)

    resources: list[CfnResource] = []
    for logical_id, body in (data.get("Resources") or {}).items():
        resources.append(
            CfnResource(
                logical_id=logical_id,
                resource_type=body.get("Type", ""),
                properties=body.get("Properties", {}),
            )
        )
    return resources


# ---------------------------------------------------------------------------
# Resource-specific extractors
# ---------------------------------------------------------------------------


def extract_lambda_functions(resources: list[CfnResource]) -> list[LambdaFunctionProps]:
    """Pull Lambda function definitions out of the resource list."""
    results: list[LambdaFunctionProps] = []
    for r in resources:
        if r.resource_type != "AWS::Lambda::Function":
            continue
        props = r.properties
        env_vars: dict[str, str] = {}
        env_block = props.get("Environment")
        if isinstance(env_block, dict):
            env_vars = env_block.get("Variables", {})
        results.append(
            LambdaFunctionProps(
                handler=props.get("Handler"),
                runtime=props.get("Runtime"),
                code_uri=props.get("Code"),
                timeout=props.get("Timeout"),
                memory_size=props.get("MemorySize"),
                environment=env_vars,
            )
        )
    return results


def extract_dynamo_tables(resources: list[CfnResource]) -> list[DynamoTableProps]:
    """Pull DynamoDB table definitions out of the resource list."""
    results: list[DynamoTableProps] = []
    for r in resources:
        if r.resource_type != "AWS::DynamoDB::Table":
            continue
        props = r.properties
        results.append(
            DynamoTableProps(
                table_name=props.get("TableName"),
                key_schema=props.get("KeySchema", []),
                attribute_definitions=props.get("AttributeDefinitions", []),
                gsi_definitions=props.get("GlobalSecondaryIndexes", []),
            )
        )
    return results


def extract_event_source_mappings(
    resources: list[CfnResource],
) -> list[EventSourceMappingProps]:
    """Pull Lambda event source mappings out of the resource list."""
    results: list[EventSourceMappingProps] = []
    for r in resources:
        if r.resource_type != "AWS::Lambda::EventSourceMapping":
            continue
        props = r.properties
        enabled = props.get("Enabled", True)
        results.append(
            EventSourceMappingProps(
                function_name=props.get("FunctionName"),
                event_source_arn=props.get("EventSourceArn"),
                batch_size=props.get("BatchSize", 10),
                enabled=enabled if isinstance(enabled, bool) else True,
            )
        )
    return results


def _build_resource_path_map(resources: list[CfnResource]) -> dict[str, str]:
    """Build a map of REST API v1 resource logical IDs -> resource paths.

    This resolves ``AWS::ApiGateway::Resource`` entries so that methods
    referencing them via ``ResourceId`` can report a human-readable path.
    """
    path_map: dict[str, str] = {}
    for r in resources:
        if r.resource_type == "AWS::ApiGateway::Resource":
            path_part = r.properties.get("PathPart", "")
            path_map[r.logical_id] = f"/{path_part}"
    return path_map


def _find_integration_ref(parts: list[Any], resources: list[CfnResource]) -> str | None:
    """Find a Ref in join parts that points to an ApiGatewayV2 Integration."""
    for part in parts:
        if not isinstance(part, dict) or "Ref" not in part:
            continue
        ref_value = part["Ref"]
        for res in resources:
            if (
                res.logical_id == ref_value
                and res.resource_type == "AWS::ApiGatewayV2::Integration"
            ):
                return ref_value
    return None


def _resolve_v2_integration_uri(target: Any, resources: list[CfnResource]) -> Any:
    """Resolve a v2 route Target to the underlying integration's IntegrationUri.

    A v2 route's ``Target`` is typically a ``Fn::Join`` that embeds a ``Ref``
    to an ``AWS::ApiGatewayV2::Integration`` resource.  The actual Lambda
    reference lives on that integration's ``IntegrationUri`` property.

    If the integration resource can be found, return its ``IntegrationUri``;
    otherwise fall back to the original *target*.
    """
    if not isinstance(target, dict):
        return target

    # Walk Fn::Join values to find a Ref to the integration resource
    join_parts = target.get("Fn::Join")
    if not isinstance(join_parts, list) or len(join_parts) < 2:
        return target

    integration_logical_id = _find_integration_ref(join_parts[1], resources)
    if not integration_logical_id:
        return target

    # Look up the integration resource and return its IntegrationUri
    for res in resources:
        if res.logical_id == integration_logical_id:
            return res.properties.get("IntegrationUri", target)

    return target


def extract_api_routes(resources: list[CfnResource]) -> list[ApiGatewayRouteProps]:
    """Extract API Gateway routes from both REST API v1 and HTTP API v2."""
    routes: list[ApiGatewayRouteProps] = []
    path_map = _build_resource_path_map(resources)

    for r in resources:
        # REST API v1 - methods
        if r.resource_type == "AWS::ApiGateway::Method":
            resource_id = r.properties.get("ResourceId")
            resource_path = path_map.get(resource_id, "/") if isinstance(resource_id, str) else "/"
            integration = r.properties.get("Integration", {})
            routes.append(
                ApiGatewayRouteProps(
                    http_method=r.properties.get("HttpMethod"),
                    resource_path=resource_path,
                    integration_uri=integration.get("Uri"),
                )
            )

        # HTTP API v2 - routes
        elif r.resource_type == "AWS::ApiGatewayV2::Route":
            route_key = r.properties.get("RouteKey", "")
            parts = route_key.split(" ", 1)
            method = parts[0] if len(parts) >= 1 else None
            path = parts[1] if len(parts) >= 2 else "/"
            target = r.properties.get("Target")
            integration_uri = _resolve_v2_integration_uri(target, resources)
            routes.append(
                ApiGatewayRouteProps(
                    http_method=method,
                    resource_path=path,
                    integration_uri=integration_uri,
                )
            )

    return routes
