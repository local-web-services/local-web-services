"""Module-level helpers and constants for LwsSession."""

from __future__ import annotations

import socket
from typing import Any

from lws_testing._spec import (
    DynamoTable,
    S3Bucket,
    Secret,
    SnsTopic,
    SqsQueue,
    SsmParameter,
    StateMachine,
)

# Maps boto3 service name → AWS SDK endpoint URL env var.
# Setting these redirects *any* boto3 client created in the process to the
# local LWS service — no production-code changes required.
SERVICE_ENV_VARS: dict[str, str] = {
    "dynamodb": "AWS_ENDPOINT_URL_DYNAMODB",
    "sqs": "AWS_ENDPOINT_URL_SQS",
    "s3": "AWS_ENDPOINT_URL_S3",
    "sns": "AWS_ENDPOINT_URL_SNS",
    "stepfunctions": "AWS_ENDPOINT_URL_STEPFUNCTIONS",
    "ssm": "AWS_ENDPOINT_URL_SSM",
    "secretsmanager": "AWS_ENDPOINT_URL_SECRETSMANAGER",
    "events": "AWS_ENDPOINT_URL_EVENTS",
    "apigateway": "AWS_ENDPOINT_URL_API_GATEWAY",
    "organizations": "AWS_ENDPOINT_URL_ORGANIZATIONS",
}

# Credential / region overrides so boto3 never tries to contact IAM or STS.
TEST_CREDENTIALS: dict[str, str] = {
    "AWS_ACCESS_KEY_ID": "test",
    "AWS_SECRET_ACCESS_KEY": "test",
    "AWS_DEFAULT_REGION": "us-east-1",
}


def parse_typed_resources(resources: tuple) -> dict[str, list]:
    """Convert typed resource objects into keyed lists for LwsSession._spec."""
    tables: list[dict[str, Any]] = []
    queues: list[str] = []
    buckets: list[str] = []
    topics: list[str] = []
    state_machines: list[dict[str, Any]] = []
    secrets: list[str] = []
    parameters: list[str] = []
    for resource in resources:
        if isinstance(resource, DynamoTable):
            entry: dict[str, Any] = {"name": resource.name, "partition_key": resource.hash_key}
            if resource.sort_key is not None:
                entry["sort_key"] = resource.sort_key
            tables.append(entry)
        elif isinstance(resource, SqsQueue):
            queues.append(resource.name)
        elif isinstance(resource, S3Bucket):
            buckets.append(resource.name)
        elif isinstance(resource, SnsTopic):
            topics.append(resource.name)
        elif isinstance(resource, StateMachine):
            state_machines.append(
                {
                    "name": resource.name,
                    "definition": resource.definition,
                    "role_arn": resource.role_arn,
                }
            )
        elif isinstance(resource, Secret):
            secrets.append(resource.name)
        elif isinstance(resource, SsmParameter):
            parameters.append(resource.name)
    return {
        "tables": tables,
        "queues": queues,
        "buckets": buckets,
        "topics": topics,
        "state_machines": state_machines,
        "secrets": secrets,
        "parameters": parameters,
    }


def free_port() -> int:
    """Return a free ephemeral TCP port on localhost."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]
