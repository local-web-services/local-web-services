"""Shared helpers for the SQS wire-protocol implementation."""

from __future__ import annotations

import json as _json
import time
import uuid
from urllib.parse import parse_qs

from fastapi import Request, Response

from lws.providers.sqs.provider import QueueConfig

# Account / region used for constructing queue URLs in responses.
_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"

_sqs_port: int = 4566


def _queue_url(queue_name: str) -> str:
    """Build a fake queue URL for *queue_name*."""
    return f"http://127.0.0.1:{_sqs_port}/{_FAKE_ACCOUNT}/{queue_name}"


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON ``Response`` for the AWS JSON 1.0 protocol."""
    return Response(
        content=_json.dumps(data),
        status_code=status_code,
        media_type="application/x-amz-json-1.0",
    )


def _json_error(code: str, message: str, status_code: int = 400) -> Response:
    """Return an SQS error response in JSON format."""
    return _json_response(
        {"__type": code, "message": message},
        status_code=status_code,
    )


def _xml_response(body: str, status_code: int = 200) -> Response:
    """Return an XML ``Response`` with the correct content type."""
    return Response(
        content=body,
        status_code=status_code,
        media_type="application/xml",
    )


def _error_xml(code: str, message: str, status_code: int = 400) -> Response:
    """Return an SQS error response in XML format."""
    xml = (
        "<ErrorResponse>"
        "<Error>"
        f"<Code>{code}</Code>"
        f"<Message>{message}</Message>"
        "</Error>"
        f"<RequestId>{uuid.uuid4()}</RequestId>"
        "</ErrorResponse>"
    )
    return _xml_response(xml, status_code=status_code)


def _count_in_flight_messages(queue: object) -> int:
    """Count messages that are currently in-flight (visibility timeout not expired)."""
    now = time.monotonic()
    count = 0
    for msg in queue.messages:  # type: ignore[attr-defined]
        if msg.receipt_handle is not None and msg.visibility_timeout_until > now:
            count += 1
    return count


def _build_queue_attrs(
    queue_name: str, queue: object, config: QueueConfig | None = None
) -> dict[str, str]:
    """Build the full set of queue attributes that Terraform expects."""

    now_ts = str(int(time.time()))
    in_flight = _count_in_flight_messages(queue)
    # Start with defaults
    attrs: dict[str, str] = {
        "QueueArn": f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{queue_name}",
        "ApproximateNumberOfMessages": str(len(queue.messages)),  # type: ignore[attr-defined]
        "ApproximateNumberOfMessagesNotVisible": str(in_flight),
        "ApproximateNumberOfMessagesDelayed": "0",
        "VisibilityTimeout": str(queue.visibility_timeout),  # type: ignore[attr-defined]
        "CreatedTimestamp": now_ts,
        "LastModifiedTimestamp": now_ts,
        "DelaySeconds": "0",
        "MaximumMessageSize": "262144",
        "MessageRetentionPeriod": "345600",
        "ReceiveMessageWaitTimeSeconds": "0",
        "SqsManagedSseEnabled": "false",
    }
    if queue.is_fifo:  # type: ignore[attr-defined]
        attrs["FifoQueue"] = "true"
        attrs["ContentBasedDeduplication"] = str(
            queue.content_based_dedup  # type: ignore[attr-defined]
        ).lower()
    if hasattr(queue, "dead_letter_queue") and queue.dead_letter_queue is not None:
        dlq_name = queue.dead_letter_queue.queue_name
        dlq_arn = f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{dlq_name}"
        max_count = getattr(queue, "max_receive_count", 5)
        attrs["RedrivePolicy"] = _json.dumps(
            {"deadLetterTargetArn": dlq_arn, "maxReceiveCount": max_count}
        )
    # Overlay any attributes that were set via CreateQueue/SetQueueAttributes
    if config is not None:
        for k, v in config.custom_attrs.items():
            if k not in ("QueueArn", "ApproximateNumberOfMessages"):
                attrs[k] = v
    return attrs


def _apply_queue_attrs(
    queue: object, attrs: dict[str, str], config: QueueConfig | None = None
) -> None:
    """Apply attribute updates to a queue and persist in config."""
    if "VisibilityTimeout" in attrs:
        queue.visibility_timeout = int(attrs["VisibilityTimeout"])  # type: ignore[attr-defined]
    if config is not None:
        config.custom_attrs.update(attrs)


def _extract_queue_tags(params: dict[str, str]) -> dict[str, str]:
    """Extract Tag.N.Key / Tag.N.Value parameters into a dict."""
    tags: dict[str, str] = {}
    n = 1
    while True:
        key = params.get(f"Tag.{n}.Key")
        if key is None:
            break
        tags[key] = params.get(f"Tag.{n}.Value", "")
        n += 1
    return tags


async def _extract_params(request: Request) -> dict[str, str]:
    """Extract action parameters from query string and/or form body."""
    params: dict[str, str] = dict(request.query_params)

    # Form body parameters (URL-encoded)
    content_type = request.headers.get("content-type", "")
    if "application/x-www-form-urlencoded" in content_type:
        body = await request.body()
        form_params = parse_qs(body.decode(), keep_blank_values=True)
        for key, values in form_params.items():
            params[key] = values[0] if values else ""

    _extract_queue_name_from_path(request.url.path, params)
    return params


def _extract_queue_name_from_path(path: str, params: dict[str, str]) -> None:
    """Populate ``_queue_name_from_path`` from the URL path if applicable."""
    path = path.strip("/")
    if not path or "QueueName" in params:
        return
    parts = path.split("/")
    if parts:
        params.setdefault("_queue_name_from_path", parts[-1])


def _extract_queue_name(params: dict[str, str]) -> str:
    """Extract the queue name from parameters or the URL path."""
    name = params.get("QueueUrl", "")
    if name:
        # QueueUrl looks like http://.../<account>/<queue_name>
        return name.rstrip("/").split("/")[-1]
    return params.get("QueueName", params.get("_queue_name_from_path", ""))


def _extract_message_attributes(params: dict[str, str]) -> dict:
    """Extract MessageAttribute.N.* parameters into a dict."""
    attrs: dict = {}
    n = 1
    while True:
        name_key = f"MessageAttribute.{n}.Name"
        if name_key not in params:
            break
        attr_name = params[name_key]
        data_type = params.get(f"MessageAttribute.{n}.Value.DataType", "String")
        string_value = params.get(f"MessageAttribute.{n}.Value.StringValue", "")
        attrs[attr_name] = {
            "DataType": data_type,
            "StringValue": string_value,
        }
        n += 1
    return attrs


def _extract_queue_attributes(params: dict[str, str]) -> dict[str, str]:
    """Extract Attribute.N.* parameters into a dict."""
    attrs: dict[str, str] = {}
    n = 1
    while True:
        name_key = f"Attribute.{n}.Name"
        if name_key not in params:
            break
        attrs[params[name_key]] = params.get(f"Attribute.{n}.Value", "")
        n += 1
    return attrs


def _build_attributes_xml(attrs: dict[str, str]) -> str:
    """Build XML for system attributes."""
    parts = []
    for name, value in attrs.items():
        parts.append(f"<Attribute><Name>{name}</Name><Value>{value}</Value></Attribute>")
    return "".join(parts)


def _build_message_attributes_xml(attrs: dict) -> str:
    """Build XML for user message attributes."""
    parts = []
    for name, value in attrs.items():
        data_type = value.get("DataType", "String") if isinstance(value, dict) else "String"
        string_value = value.get("StringValue", "") if isinstance(value, dict) else str(value)
        parts.append(
            f"<MessageAttribute>"
            f"<Name>{name}</Name>"
            f"<Value>"
            f"<DataType>{data_type}</DataType>"
            f"<StringValue>{string_value}</StringValue>"
            f"</Value>"
            f"</MessageAttribute>"
        )
    return "".join(parts)


def _extract_queue_name_from_url(queue_url: str) -> str:
    """Extract queue name from a QueueUrl like ``http://.../<account>/<name>``."""
    if queue_url:
        return queue_url.rstrip("/").split("/")[-1]
    return ""
