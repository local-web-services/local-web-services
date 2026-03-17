"""Helper and utility functions for CDK assembly parsing.

Contains Ref resolution logic, code path resolution, and other
pure helper functions used by the assembly orchestrator.
"""

from __future__ import annotations

from collections.abc import Callable
from pathlib import Path
from typing import Any

from lws.parser.ref_resolver import RefResolver
from lws.parser.template_parser import CfnResource


# ---------------------------------------------------------------------------
# Ref resolution helpers
# ---------------------------------------------------------------------------


def _ref_sqs(r: CfnResource) -> str | None:
    queue_name = r.properties.get("QueueName", r.logical_id)
    if isinstance(queue_name, str):
        return f"arn:ldk:sqs:local:000000000000:queue/{queue_name}"
    return None


def _ref_dynamodb(r: CfnResource) -> str | None:
    table_name = r.properties.get("TableName", r.logical_id)
    return table_name if isinstance(table_name, str) else None


def _ref_s3(r: CfnResource) -> str:
    bucket_name = r.properties.get("BucketName", r.logical_id)
    return bucket_name if isinstance(bucket_name, str) else r.logical_id


def _ref_sns(r: CfnResource) -> str | None:
    topic_name = r.properties.get("TopicName", r.logical_id)
    if isinstance(topic_name, str):
        return f"arn:ldk:sns:local:000000000000:{topic_name}"
    return None


def _ref_ssm(r: CfnResource) -> str | None:
    name = r.properties.get("Name", r.logical_id)
    return name if isinstance(name, str) else None


def _ref_secretsmanager(r: CfnResource) -> str | None:
    name = r.properties.get("Name", r.logical_id)
    if isinstance(name, str):
        return f"arn:aws:secretsmanager:us-east-1:000000000000:secret:{name}"
    return None


_REF_RESOLVERS: dict[str, Callable[[CfnResource], str | None]] = {
    "AWS::SQS::Queue": _ref_sqs,
    "AWS::DynamoDB::Table": _ref_dynamodb,
    "AWS::S3::Bucket": _ref_s3,
    "AWS::SNS::Topic": _ref_sns,
    "AWS::SSM::Parameter": _ref_ssm,
    "AWS::SecretsManager::Secret": _ref_secretsmanager,
}


def _resolve_ref_value(r: CfnResource) -> str | None:
    """Return the local Ref value for a single CloudFormation resource, or None."""
    handler = _REF_RESOLVERS.get(r.resource_type)
    if handler is not None:
        return handler(r)
    return None


def build_resource_map(resources: list[CfnResource]) -> dict[str, str]:
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
        ref = _resolve_ref_value(r)
        if ref is not None:
            resource_map[r.logical_id] = ref
    return resource_map


# ---------------------------------------------------------------------------
# Code path resolution helpers
# ---------------------------------------------------------------------------


def resolve_code_from_s3_key(s3_key: str, asset_map: dict[str, Path]) -> Path | None:
    """Try to match an S3Key to an asset by hash."""
    asset_hash = s3_key.replace(".zip", "")
    if asset_hash in asset_map:
        return asset_map[asset_hash]
    for hash_key, path in asset_map.items():
        if hash_key in s3_key:
            return path
    return None


def resolve_code_from_s3_bucket(
    s3_bucket: dict, resolver: RefResolver, asset_map: dict[str, Path]
) -> Path | None:
    """Try to match an S3Bucket ref to an asset."""
    resolved = str(resolver.resolve(s3_bucket))
    for h, p in asset_map.items():
        if h in resolved:
            return p
    return None


def resolve_code_path(
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
            result = resolve_code_from_s3_key(s3_key, asset_map)
            if result:
                return result

        s3_bucket = code_uri.get("S3Bucket")
        if isinstance(s3_bucket, dict):
            result = resolve_code_from_s3_bucket(s3_bucket, resolver, asset_map)
            if result:
                return result

    if isinstance(code_uri, str):
        candidate = cdk_out_path / code_uri
        if candidate.exists():
            return candidate

    return None


def find_handler_for_integration(
    integration_uri: Any,
    resources: list[CfnResource],
    resolver: RefResolver,
) -> str | None:
    """Try to match an API integration URI back to a Lambda logical ID."""
    if integration_uri is None:
        return None

    resolved = str(resolver.resolve(integration_uri))

    for r in resources:
        if r.resource_type == "AWS::Lambda::Function":
            if r.logical_id in resolved:
                return r.logical_id

    return None


# ---------------------------------------------------------------------------
# Miscellaneous helpers
# ---------------------------------------------------------------------------


def extract_website_configuration(properties: dict[str, Any]) -> dict[str, Any] | None:
    """Extract WebsiteConfiguration from CloudFormation S3 bucket properties."""
    raw = properties.get("WebsiteConfiguration")
    if not raw or not isinstance(raw, dict):
        return None
    config: dict[str, Any] = {}
    index_doc = raw.get("IndexDocument")
    if isinstance(index_doc, str):
        config["index_document"] = index_doc
    error_doc = raw.get("ErrorDocument")
    if isinstance(error_doc, str):
        config["error_document"] = error_doc
    return config if config else None


def resolve_sm_definition(definition: Any, resolver: RefResolver) -> Any:
    """Resolve a Step Functions DefinitionString that may use intrinsic functions."""
    if isinstance(definition, dict):
        return resolver.resolve(definition)
    return definition


def resolve_substitutions(subs: dict[str, Any], resolver: RefResolver) -> dict[str, str]:
    """Resolve CloudFormation DefinitionSubstitutions to plain strings."""
    return {k: str(resolver.resolve(v)) if isinstance(v, dict) else str(v) for k, v in subs.items()}
