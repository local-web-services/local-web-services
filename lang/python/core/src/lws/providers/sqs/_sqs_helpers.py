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


async def _send_message_and_get_md5(
    provider: object, queue_name: str, msg_body: str, delay: int
) -> tuple[str, str]:
    """Send *msg_body* to *queue_name* and return ``(message_id, md5_body)``."""
    import hashlib  # pylint: disable=import-outside-toplevel

    message_id = await provider.send_message(  # type: ignore[attr-defined]
        queue_name=queue_name,
        message_body=msg_body,
        delay_seconds=delay,
    )
    md5_body = hashlib.md5(msg_body.encode()).hexdigest()
    return message_id, md5_body


async def _do_delete_queue(
    provider: object, tracker: object, lifecycle: object, queue_name: str
) -> None:
    """Delete *queue_name* via *provider* and update *tracker* according to *lifecycle*."""
    await provider.delete_queue(queue_name)  # type: ignore[attr-defined]
    if lifecycle.enabled and lifecycle.delete_dwell_ms > 0:  # type: ignore[attr-defined]
        tracker.set_state(queue_name, "DELETING")  # type: ignore[attr-defined]
        tracker.schedule_transition(queue_name, None, lifecycle.delete_dwell_ms)  # type: ignore[attr-defined]
    else:
        tracker.remove(queue_name)  # type: ignore[attr-defined]


def _nonexistent_queue_error_xml(queue_name: str) -> Response:
    """Return a standard NonExistentQueue error XML response."""
    return _error_xml(
        "AWS.SimpleQueueService.NonExistentQueue",
        f"The specified queue does not exist: {queue_name}",
        status_code=400,
    )


def _get_queue_or_error_xml(provider: object, queue_name: str) -> tuple:
    """Return ``(queue, None)`` if queue exists, or ``(None, error_response)`` otherwise."""
    queue = provider.get_queue(queue_name)  # type: ignore[attr-defined]
    if queue is None:
        return None, _nonexistent_queue_error_xml(queue_name)
    return queue, None


def _apply_visibility_timeout_to_messages(
    queue: object, messages: list, visibility_timeout: str
) -> None:
    """Update visibility timeouts for *messages* to *visibility_timeout* seconds."""
    vt = int(visibility_timeout)
    now = time.monotonic()
    for msg_dict in messages:
        for m in queue.messages:  # type: ignore[attr-defined]
            if m.message_id == msg_dict["MessageId"]:
                m.visibility_timeout_until = now + vt


def _find_and_update_visibility(queue: object, receipt_handle: str, vt: int, now: float) -> bool:
    """Set *vt* on the message with *receipt_handle*. Returns True if found."""
    found = False
    for msg in queue.messages:  # type: ignore[attr-defined]
        if msg.receipt_handle == receipt_handle:
            msg.visibility_timeout_until = now + vt
            found = True
            break
    return found


def _validate_redrive_policy(
    attrs: dict, queue: object, config: object, provider: object, get_lifecycle_error: object
) -> Response | None:
    """Validate the RedrivePolicy attribute value.

    Returns an error Response if invalid, or None if valid.
    """
    existing_policy = (
        config.custom_attrs.get("RedrivePolicy") if config else None  # type: ignore[union-attr]
    ) or (
        queue.dead_letter_queue is not None
    )  # type: ignore[union-attr]
    if existing_policy:
        return _json_error(
            "InvalidParameterValue",
            "A dead-letter queue is already configured for this queue.",
            status_code=400,
        )
    try:
        redrive = _json.loads(attrs["RedrivePolicy"])
        dlq_arn = redrive.get("deadLetterTargetArn", "")
        dlq_name = dlq_arn.split(":")[-1] if ":" in dlq_arn else dlq_arn
    except (ValueError, KeyError):
        dlq_name = ""
        dlq_arn = ""
    if not dlq_name:
        return None
    dlq = provider.get_queue(dlq_name)  # type: ignore[union-attr]
    if dlq is None:
        return _json_error(
            "InvalidParameterValue",
            f"Value {dlq_arn!r} for parameter RedrivePolicy is invalid. "
            "Reason: Dead letter target does not exist.",
            status_code=400,
        )
    dlq_lifecycle_err = get_lifecycle_error(dlq_name)  # type: ignore[operator]
    if dlq_lifecycle_err is not None:
        return _json_error(
            "InvalidParameterValue",
            f"Value {dlq_arn!r} for parameter RedrivePolicy is invalid. "
            "Reason: Dead letter target is not ACTIVE.",
            status_code=400,
        )
    return None
