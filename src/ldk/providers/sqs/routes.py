"""SQS wire-protocol HTTP server.

Implements both the legacy SQS query-string / form-body protocol and
the AWS JSON 1.0 protocol (``X-Amz-Target: AmazonSQS.*``) that newer
AWS SDKs use.
"""

from __future__ import annotations

import hashlib
import json as _json
import time
import uuid
from urllib.parse import parse_qs

from fastapi import APIRouter, FastAPI, Request, Response

from ldk.logging.logger import get_logger
from ldk.logging.middleware import RequestLoggingMiddleware
from ldk.providers.sqs.provider import QueueConfig, SqsProvider

_logger = get_logger("ldk.sqs")

# Account / region used for constructing queue URLs in responses.
_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"


class SqsRouter:
    """Route SQS wire-protocol requests to an ``SqsProvider`` backend."""

    def __init__(self, provider: SqsProvider) -> None:
        self.provider = provider
        self.router = APIRouter()
        self.router.add_api_route("/", self._dispatch, methods=["POST", "GET"])
        self.router.add_api_route("/{path:path}", self._dispatch, methods=["POST", "GET"])

    # ------------------------------------------------------------------
    # Dispatch
    # ------------------------------------------------------------------

    async def _dispatch(self, request: Request) -> Response:
        # Detect AWS JSON 1.0 protocol via X-Amz-Target header
        amz_target = request.headers.get("x-amz-target", "")
        if amz_target.startswith("AmazonSQS."):
            action = amz_target[len("AmazonSQS.") :]
            body = await request.json()
            handler = self._json_handlers().get(action)
            if handler is None:
                return _json_error("InvalidAction", f"Unknown action: {action}")
            return await handler(body)

        params = await _extract_params(request)
        action = params.get("Action", "")

        handler = self._handlers().get(action)
        if handler is None:
            return _error_xml("InvalidAction", f"Unknown action: {action}")

        return await handler(params)

    def _handlers(self) -> dict:
        return {
            "SendMessage": self._send_message,
            "ReceiveMessage": self._receive_message,
            "DeleteMessage": self._delete_message,
            "CreateQueue": self._create_queue,
            "GetQueueUrl": self._get_queue_url,
            "GetQueueAttributes": self._get_queue_attributes,
        }

    def _json_handlers(self) -> dict:
        return {
            "SendMessage": self._json_send_message,
            "ReceiveMessage": self._json_receive_message,
            "DeleteMessage": self._json_delete_message,
            "CreateQueue": self._json_create_queue,
            "GetQueueUrl": self._json_get_queue_url,
            "GetQueueAttributes": self._json_get_queue_attributes,
        }

    # ------------------------------------------------------------------
    # Action handlers
    # ------------------------------------------------------------------

    async def _send_message(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        body = params.get("MessageBody", "")
        delay = int(params.get("DelaySeconds", "0"))

        message_attributes = _extract_message_attributes(params)

        message_id = await self.provider.send_message(
            queue_name=queue_name,
            message_body=body,
            message_attributes=message_attributes or None,
            delay_seconds=delay,
        )

        md5_body = hashlib.md5(body.encode()).hexdigest()
        xml = (
            "<SendMessageResponse>"
            "<SendMessageResult>"
            f"<MessageId>{message_id}</MessageId>"
            f"<MD5OfMessageBody>{md5_body}</MD5OfMessageBody>"
            "</SendMessageResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</SendMessageResponse>"
        )
        return _xml_response(xml)

    async def _receive_message(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        max_messages = int(params.get("MaxNumberOfMessages", "1"))
        wait_time = int(params.get("WaitTimeSeconds", "0"))
        visibility_timeout = params.get("VisibilityTimeout")

        messages = await self.provider.receive_messages(
            queue_name=queue_name,
            max_messages=max_messages,
            wait_time_seconds=wait_time,
        )

        # Apply per-request visibility timeout override if provided
        if visibility_timeout is not None:
            queue = self.provider.get_queue(queue_name)
            if queue is not None:
                vt = int(visibility_timeout)
                import time as _time

                now = _time.monotonic()
                for msg_dict in messages:
                    # Find the underlying message and adjust
                    for m in queue._messages:
                        if m.message_id == msg_dict["MessageId"]:
                            m.visibility_timeout_until = now + vt

        msg_xml_parts: list[str] = []
        for msg in messages:
            attrs_xml = _build_attributes_xml(msg.get("Attributes", {}))
            msg_attrs_xml = _build_message_attributes_xml(msg.get("MessageAttributes", {}))
            msg_xml_parts.append(
                "<Message>"
                f"<MessageId>{msg['MessageId']}</MessageId>"
                f"<ReceiptHandle>{msg['ReceiptHandle']}</ReceiptHandle>"
                f"<Body>{msg['Body']}</Body>"
                f"<MD5OfBody>{msg['MD5OfBody']}</MD5OfBody>"
                f"{attrs_xml}"
                f"{msg_attrs_xml}"
                "</Message>"
            )

        xml = (
            "<ReceiveMessageResponse>"
            "<ReceiveMessageResult>"
            f"{''.join(msg_xml_parts)}"
            "</ReceiveMessageResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ReceiveMessageResponse>"
        )
        return _xml_response(xml)

    async def _delete_message(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        receipt_handle = params.get("ReceiptHandle", "")

        await self.provider.delete_message(queue_name, receipt_handle)

        xml = (
            "<DeleteMessageResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</DeleteMessageResponse>"
        )
        return _xml_response(xml)

    async def _create_queue(self, params: dict) -> Response:
        queue_name = params.get("QueueName", "")
        is_fifo = queue_name.endswith(".fifo")

        attrs = _extract_queue_attributes(params)
        visibility_timeout = int(attrs.get("VisibilityTimeout", "30"))
        content_based_dedup = attrs.get("ContentBasedDeduplication", "false").lower() == "true"

        config = QueueConfig(
            queue_name=queue_name,
            visibility_timeout=visibility_timeout,
            is_fifo=is_fifo,
            content_based_dedup=content_based_dedup,
        )
        self.provider.create_queue(config)

        queue_url = _queue_url(queue_name)
        xml = (
            "<CreateQueueResponse>"
            "<CreateQueueResult>"
            f"<QueueUrl>{queue_url}</QueueUrl>"
            "</CreateQueueResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</CreateQueueResponse>"
        )
        return _xml_response(xml)

    async def _get_queue_url(self, params: dict) -> Response:
        queue_name = params.get("QueueName", "")
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )

        queue_url = _queue_url(queue_name)
        xml = (
            "<GetQueueUrlResponse>"
            "<GetQueueUrlResult>"
            f"<QueueUrl>{queue_url}</QueueUrl>"
            "</GetQueueUrlResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</GetQueueUrlResponse>"
        )
        return _xml_response(xml)

    # ------------------------------------------------------------------
    # JSON protocol action handlers (AWS JSON 1.0)
    # ------------------------------------------------------------------

    async def _json_send_message(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        msg_body = body.get("MessageBody", "")
        delay = int(body.get("DelaySeconds", 0))
        message_attributes = body.get("MessageAttributes", {})

        message_id = await self.provider.send_message(
            queue_name=queue_name,
            message_body=msg_body,
            message_attributes=message_attributes or None,
            delay_seconds=delay,
        )

        md5_body = hashlib.md5(msg_body.encode()).hexdigest()
        return _json_response(
            {
                "MessageId": message_id,
                "MD5OfMessageBody": md5_body,
            }
        )

    async def _json_receive_message(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        max_messages = int(body.get("MaxNumberOfMessages", 1))
        wait_time = int(body.get("WaitTimeSeconds", 0))
        visibility_timeout = body.get("VisibilityTimeout")

        messages = await self.provider.receive_messages(
            queue_name=queue_name,
            max_messages=max_messages,
            wait_time_seconds=wait_time,
        )

        if visibility_timeout is not None:
            queue = self.provider.get_queue(queue_name)
            if queue is not None:
                vt = int(visibility_timeout)
                import time as _time

                now = _time.monotonic()
                for msg_dict in messages:
                    for m in queue._messages:
                        if m.message_id == msg_dict["MessageId"]:
                            m.visibility_timeout_until = now + vt

        json_messages = []
        for msg in messages:
            json_msg: dict = {
                "MessageId": msg["MessageId"],
                "ReceiptHandle": msg["ReceiptHandle"],
                "Body": msg["Body"],
                "MD5OfBody": msg["MD5OfBody"],
            }
            if msg.get("Attributes"):
                json_msg["Attributes"] = msg["Attributes"]
            if msg.get("MessageAttributes"):
                json_msg["MessageAttributes"] = msg["MessageAttributes"]
            json_messages.append(json_msg)

        return _json_response({"Messages": json_messages})

    async def _json_delete_message(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        receipt_handle = body.get("ReceiptHandle", "")
        await self.provider.delete_message(queue_name, receipt_handle)
        return _json_response({})

    async def _json_create_queue(self, body: dict) -> Response:
        queue_name = body.get("QueueName", "")
        is_fifo = queue_name.endswith(".fifo")
        attrs = body.get("Attributes", {})
        visibility_timeout = int(attrs.get("VisibilityTimeout", "30"))
        content_based_dedup = str(attrs.get("ContentBasedDeduplication", "false")).lower() == "true"

        config = QueueConfig(
            queue_name=queue_name,
            visibility_timeout=visibility_timeout,
            is_fifo=is_fifo,
            content_based_dedup=content_based_dedup,
        )
        self.provider.create_queue(config)
        return _json_response({"QueueUrl": _queue_url(queue_name)})

    async def _json_get_queue_url(self, body: dict) -> Response:
        queue_name = body.get("QueueName", "")
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({"QueueUrl": _queue_url(queue_name)})

    async def _json_get_queue_attributes(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        attrs = {
            "QueueArn": f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{queue_name}",
            "ApproximateNumberOfMessages": str(len(queue._messages)),
            "VisibilityTimeout": str(queue.visibility_timeout),
            "CreatedTimestamp": str(int(time.time())),
            "LastModifiedTimestamp": str(int(time.time())),
        }
        if queue.is_fifo:
            attrs["FifoQueue"] = "true"
            attrs["ContentBasedDeduplication"] = str(queue.content_based_dedup).lower()
        return _json_response({"Attributes": attrs})

    # ------------------------------------------------------------------
    # Legacy XML action handlers
    # ------------------------------------------------------------------

    async def _get_queue_attributes(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )

        attrs = {
            "QueueArn": f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{queue_name}",
            "ApproximateNumberOfMessages": str(len(queue._messages)),
            "VisibilityTimeout": str(queue.visibility_timeout),
            "CreatedTimestamp": str(int(time.time())),
            "LastModifiedTimestamp": str(int(time.time())),
        }
        if queue.is_fifo:
            attrs["FifoQueue"] = "true"
            attrs["ContentBasedDeduplication"] = str(queue.content_based_dedup).lower()

        attrs_xml = "".join(
            f"<Attribute><Name>{k}</Name><Value>{v}</Value></Attribute>" for k, v in attrs.items()
        )
        xml = (
            "<GetQueueAttributesResponse>"
            "<GetQueueAttributesResult>"
            f"{attrs_xml}"
            "</GetQueueAttributesResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</GetQueueAttributesResponse>"
        )
        return _xml_response(xml)


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


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


def _queue_url(queue_name: str) -> str:
    """Build a fake queue URL for *queue_name*."""
    return f"http://localhost:4566/{_FAKE_ACCOUNT}/{queue_name}"


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


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_sqs_app(provider: SqsProvider) -> FastAPI:
    """Create a FastAPI application that speaks the SQS wire protocol."""
    app = FastAPI()
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sqs")
    sqs_router = SqsRouter(provider)
    app.include_router(sqs_router.router)
    return app
