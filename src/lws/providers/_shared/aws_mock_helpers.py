"""DSL helper expansion for AWS operation mocks.

Each helper converts a user-friendly shorthand (e.g. ``body_string``,
``item``, ``messages``) into a full ``AwsMockResponse`` with the correct
body format and content type for the target service.
"""

from __future__ import annotations

import json
import uuid
from pathlib import Path
from typing import Any

from lws.providers._shared.aws_operation_mock import AwsMockResponse

# ------------------------------------------------------------------
# Dispatcher
# ------------------------------------------------------------------

_HELPER_REGISTRY: dict[tuple[str, str], Any] = {}


def _register(service: str, operation: str):  # noqa: ANN202
    """Decorator to register a helper expansion function."""

    def _decorator(func):  # noqa: ANN001, ANN202
        _HELPER_REGISTRY[(service, operation)] = func
        return func

    return _decorator


def expand_helpers(
    service: str,
    operation: str,
    helpers: dict[str, Any],
    mock_dir: Path | None = None,
) -> AwsMockResponse:
    """Expand a helpers dict into an AwsMockResponse."""
    func = _HELPER_REGISTRY.get((service, operation))
    if func is None:
        raise ValueError(f"No helper registered for {service}/{operation}")
    import inspect  # pylint: disable=import-outside-toplevel

    sig = inspect.signature(func)
    if "mock_dir" in sig.parameters:
        return func(helpers, mock_dir=mock_dir)
    return func(helpers)


# ------------------------------------------------------------------
# S3 helpers
# ------------------------------------------------------------------


@_register("s3", "get-object")
def _expand_s3_get_object(helpers: dict[str, Any], mock_dir: Path | None = None) -> AwsMockResponse:
    ct = helpers.get("content_type", "application/octet-stream")
    if "body_string" in helpers:
        return AwsMockResponse(status=200, body=helpers["body_string"], content_type=ct)
    if "body_file" in helpers:
        file_path = Path(helpers["body_file"])
        if mock_dir and not file_path.is_absolute():
            file_path = mock_dir / file_path
        content = file_path.read_text(encoding="utf-8")
        return AwsMockResponse(status=200, body=content, content_type=ct)
    return AwsMockResponse(status=200, body="", content_type=ct)


@_register("s3", "list-objects-v2")
def _expand_s3_list_objects_v2(helpers: dict[str, Any]) -> AwsMockResponse:
    keys = helpers.get("keys", [])
    contents = "".join(f"<Contents><Key>{key}</Key><Size>0</Size></Contents>" for key in keys)
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        '<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
        f"<KeyCount>{len(keys)}</KeyCount>"
        f"<MaxKeys>1000</MaxKeys>"
        f"<IsTruncated>false</IsTruncated>"
        f"{contents}"
        "</ListBucketResult>"
    )
    return AwsMockResponse(status=200, body=body, content_type="application/xml")


@_register("s3", "head-object")
def _expand_s3_head_object(helpers: dict[str, Any]) -> AwsMockResponse:
    headers: dict[str, str] = {}
    if "content_type" in helpers:
        headers["Content-Type"] = helpers["content_type"]
    if "content_length" in helpers:
        headers["Content-Length"] = str(helpers["content_length"])
    if "etag" in helpers:
        headers["ETag"] = helpers["etag"]
    return AwsMockResponse(status=200, body="", content_type="text/plain", headers=headers)


# ------------------------------------------------------------------
# DynamoDB helpers
# ------------------------------------------------------------------


def simple_json_to_dynamodb_json(item: dict[str, Any]) -> dict[str, Any]:
    """Convert plain JSON values to DynamoDB JSON format.

    ``{"id": "abc", "age": 30}`` becomes
    ``{"id": {"S": "abc"}, "age": {"N": "30"}}``.
    """
    result: dict[str, Any] = {}
    for key, value in item.items():
        result[key] = _to_dynamodb_type(value)
    return result


def _to_dynamodb_type(value: Any) -> dict[str, Any]:
    """Convert a single value to its DynamoDB type descriptor."""
    if isinstance(value, str):
        return {"S": value}
    if isinstance(value, bool):
        return {"BOOL": value}
    if isinstance(value, (int, float)):
        return {"N": str(value)}
    if value is None:
        return {"NULL": True}
    if isinstance(value, list):
        return {"L": [_to_dynamodb_type(v) for v in value]}
    if isinstance(value, dict):
        return {"M": simple_json_to_dynamodb_json(value)}
    return {"S": str(value)}


@_register("dynamodb", "get-item")
def _expand_dynamodb_get_item(helpers: dict[str, Any]) -> AwsMockResponse:
    item = helpers.get("item", {})
    dynamo_item = simple_json_to_dynamodb_json(item)
    body = json.dumps({"Item": dynamo_item})
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.0")


@_register("dynamodb", "query")
def _expand_dynamodb_query(helpers: dict[str, Any]) -> AwsMockResponse:
    items = helpers.get("items", [])
    count = helpers.get("count", len(items))
    dynamo_items = [simple_json_to_dynamodb_json(item) for item in items]
    body = json.dumps(
        {
            "Items": dynamo_items,
            "Count": count,
            "ScannedCount": count,
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.0")


@_register("dynamodb", "scan")
def _expand_dynamodb_scan(helpers: dict[str, Any]) -> AwsMockResponse:
    return _expand_dynamodb_query(helpers)


# ------------------------------------------------------------------
# SQS helpers
# ------------------------------------------------------------------


@_register("sqs", "receive-message")
def _expand_sqs_receive_message(helpers: dict[str, Any]) -> AwsMockResponse:
    messages = helpers.get("messages", [])
    msg_xml_parts: list[str] = []
    for msg in messages:
        msg_id = str(uuid.uuid4())
        receipt = str(uuid.uuid4())
        body_text = msg.get("body", "")
        msg_xml_parts.append(
            "<Message>"
            f"<MessageId>{msg_id}</MessageId>"
            f"<ReceiptHandle>{receipt}</ReceiptHandle>"
            f"<Body>{body_text}</Body>"
            "</Message>"
        )
    body = (
        "<ReceiveMessageResponse>"
        "<ReceiveMessageResult>"
        f"{''.join(msg_xml_parts)}"
        "</ReceiveMessageResult>"
        "</ReceiveMessageResponse>"
    )
    return AwsMockResponse(status=200, body=body, content_type="application/xml")


# ------------------------------------------------------------------
# SSM helpers
# ------------------------------------------------------------------


@_register("ssm", "get-parameter")
def _expand_ssm_get_parameter(helpers: dict[str, Any]) -> AwsMockResponse:
    name = helpers.get("name", "/unknown")
    value = helpers.get("value", "")
    param_type = helpers.get("type", "String")
    body = json.dumps(
        {
            "Parameter": {
                "Name": name,
                "Value": value,
                "Type": param_type,
                "Version": 1,
                "ARN": f"arn:aws:ssm:us-east-1:000000000000:parameter{name}",
            }
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.1")


@_register("ssm", "get-parameters-by-path")
def _expand_ssm_get_parameters_by_path(helpers: dict[str, Any]) -> AwsMockResponse:
    parameters = helpers.get("parameters", [])
    params = []
    for p in parameters:
        name = p.get("name", "/unknown")
        params.append(
            {
                "Name": name,
                "Value": p.get("value", ""),
                "Type": p.get("type", "String"),
                "Version": 1,
                "ARN": f"arn:aws:ssm:us-east-1:000000000000:parameter{name}",
            }
        )
    body = json.dumps({"Parameters": params})
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.1")


# ------------------------------------------------------------------
# Secrets Manager helpers
# ------------------------------------------------------------------


@_register("secretsmanager", "get-secret-value")
def _expand_secretsmanager_get_secret_value(
    helpers: dict[str, Any], mock_dir: Path | None = None
) -> AwsMockResponse:
    name = helpers.get("name", "unknown")
    arn = f"arn:aws:secretsmanager:us-east-1:000000000000:secret:{name}"
    secret_string = helpers.get("secret_string", "")
    if "secret_file" in helpers:
        file_path = Path(helpers["secret_file"])
        if mock_dir and not file_path.is_absolute():
            file_path = mock_dir / file_path
        secret_string = file_path.read_text(encoding="utf-8")
    body = json.dumps(
        {
            "ARN": arn,
            "Name": name,
            "SecretString": secret_string,
            "VersionId": str(uuid.uuid4()),
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.1")


# ------------------------------------------------------------------
# Cognito helpers
# ------------------------------------------------------------------


@_register("cognito-idp", "initiate-auth")
def _expand_cognito_initiate_auth(helpers: dict[str, Any]) -> AwsMockResponse:
    body = json.dumps(
        {
            "AuthenticationResult": {
                "IdToken": helpers.get("id_token", "mock-id-token"),
                "AccessToken": helpers.get("access_token", "mock-access-token"),
                "RefreshToken": helpers.get("refresh_token", "mock-refresh-token"),
                "ExpiresIn": helpers.get("expires_in", 3600),
                "TokenType": "Bearer",
            }
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.1")


# ------------------------------------------------------------------
# Step Functions helpers
# ------------------------------------------------------------------


@_register("stepfunctions", "start-sync-execution")
def _expand_stepfunctions_start_sync_execution(
    helpers: dict[str, Any],
) -> AwsMockResponse:
    execution_arn = "arn:aws:states:us-east-1:000000000000:execution:mock-state-machine:" + str(
        uuid.uuid4()
    )
    body = json.dumps(
        {
            "executionArn": execution_arn,
            "output": helpers.get("output", "{}"),
            "status": helpers.get("status", "SUCCEEDED"),
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.0")


@_register("stepfunctions", "start-execution")
def _expand_stepfunctions_start_execution(helpers: dict[str, Any]) -> AwsMockResponse:
    return _expand_stepfunctions_start_sync_execution(helpers)


# ------------------------------------------------------------------
# EventBridge helpers
# ------------------------------------------------------------------


@_register("events", "put-events")
def _expand_eventbridge_put_events(helpers: dict[str, Any]) -> AwsMockResponse:
    failed_count = helpers.get("failed_count", 0)
    entry_count = helpers.get("entry_count", 1)
    entries = [{"EventId": str(uuid.uuid4())} for _ in range(entry_count)]
    body = json.dumps(
        {
            "Entries": entries,
            "FailedEntryCount": failed_count,
        }
    )
    return AwsMockResponse(status=200, body=body, content_type="application/x-amz-json-1.1")


# ------------------------------------------------------------------
# SNS helpers
# ------------------------------------------------------------------


@_register("sns", "publish")
def _expand_sns_publish(helpers: dict[str, Any]) -> AwsMockResponse:
    message_id = helpers.get("message_id", str(uuid.uuid4()))
    body = (
        "<PublishResponse>"
        "<PublishResult>"
        f"<MessageId>{message_id}</MessageId>"
        "</PublishResult>"
        "</PublishResponse>"
    )
    return AwsMockResponse(status=200, body=body, content_type="application/xml")
