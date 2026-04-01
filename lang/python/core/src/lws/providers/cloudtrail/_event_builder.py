"""Build full CloudTrail event envelopes from ASGI request/response pairs."""

from __future__ import annotations

import datetime
import uuid
from typing import Any

_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"
_EVENT_VERSION = "1.08"

_DATA_PLANE_OPS: dict[str, set[str]] = {
    "s3": {"GetObject", "PutObject", "DeleteObject", "HeadObject", "CopyObject"},
    "dynamodb": {
        "GetItem",
        "PutItem",
        "UpdateItem",
        "DeleteItem",
        "Query",
        "Scan",
        "BatchGetItem",
        "BatchWriteItem",
        "TransactGetItems",
        "TransactWriteItems",
    },
}

_SERVICE_SOURCES: dict[str, str] = {
    "s3": "s3.amazonaws.com",
    "sqs": "sqs.amazonaws.com",
    "sns": "sns.amazonaws.com",
    "dynamodb": "dynamodb.amazonaws.com",
    "events": "events.amazonaws.com",
    "stepfunctions": "states.amazonaws.com",
    "cognito-idp": "cognito-idp.amazonaws.com",
    "lambda": "lambda.amazonaws.com",
    "secretsmanager": "secretsmanager.amazonaws.com",
    "ssm": "ssm.amazonaws.com",
    "rds": "rds.amazonaws.com",
    "docdb": "docdb.amazonaws.com",
    "elasticache": "elasticache.amazonaws.com",
    "memorydb": "memorydb.amazonaws.com",
    "neptune": "neptune.amazonaws.com",
    "es": "es.amazonaws.com",
    "opensearch": "opensearch.amazonaws.com",
    "glacier": "glacier.amazonaws.com",
    "s3tables": "s3tables.amazonaws.com",
    "iam": "iam.amazonaws.com",
    "organizations": "organizations.amazonaws.com",
    "sts": "sts.amazonaws.com",
    "cloudtrail": "cloudtrail.amazonaws.com",
}


def _event_type(service: str, operation: str) -> str:
    ops = _DATA_PLANE_OPS.get(service, set())
    return "AwsApiCall" if operation not in ops else "AwsApiCall"


def _is_read_only(operation: str) -> bool:
    prefixes = ("Get", "List", "Describe", "Head", "Query", "Scan", "Lookup")
    return any(operation.startswith(p) for p in prefixes)


def build_cloudtrail_event(
    service: str,
    operation: str,
    source_ip: str,
    username: str,
    status_code: int,  # pylint: disable=unused-argument
    error_code: str | None = None,
    error_message: str | None = None,
    request_parameters: dict[str, Any] | None = None,
    response_elements: dict[str, Any] | None = None,
    resources: list[dict[str, str]] | None = None,
) -> dict[str, Any]:
    """Build a full CloudTrail event envelope."""
    now = datetime.datetime.now(datetime.UTC)
    event_source = _SERVICE_SOURCES.get(service, f"{service}.amazonaws.com")

    event: dict[str, Any] = {
        "eventVersion": _EVENT_VERSION,
        "userIdentity": {
            "type": "IAMUser",
            "principalId": username,
            "arn": f"arn:aws:iam::{_FAKE_ACCOUNT}:user/{username}",
            "accountId": _FAKE_ACCOUNT,
            "userName": username,
        },
        "eventTime": now.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "eventSource": event_source,
        "eventName": operation,
        "awsRegion": _FAKE_REGION,
        "sourceIPAddress": source_ip,
        "userAgent": "lws-local",
        "requestParameters": request_parameters or {},
        "responseElements": response_elements,
        "eventType": _event_type(service, operation),
        "eventID": str(uuid.uuid4()),
        "readOnly": _is_read_only(operation),
        "recipientAccountId": _FAKE_ACCOUNT,
        "managementEvent": operation not in _DATA_PLANE_OPS.get(service, set()),
    }

    if error_code:
        event["errorCode"] = error_code
        event["errorMessage"] = error_message or error_code

    if resources:
        event["resources"] = resources

    return event
