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

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_operation_mock import AwsMockConfig, AwsOperationMockMiddleware
from lws.providers.sqs.provider import QueueConfig, SqsProvider, build_queue_config

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
                _logger.warning("Unknown SQS JSON action: %s", action)
                return _json_error(
                    "UnknownOperationException",
                    f"lws: SQS operation '{action}' is not yet implemented",
                )
            return await handler(body)

        params = await _extract_params(request)
        action = params.get("Action", "")

        handler = self._handlers().get(action)
        if handler is None:
            _logger.warning("Unknown SQS XML action: %s", action)
            return _error_xml(
                "InvalidAction",
                f"lws: SQS operation '{action}' is not yet implemented",
            )

        return await handler(params)

    def _handlers(self) -> dict:
        return {
            "SendMessage": self._send_message,
            "ReceiveMessage": self._receive_message,
            "DeleteMessage": self._delete_message,
            "CreateQueue": self._create_queue,
            "DeleteQueue": self._delete_queue,
            "GetQueueUrl": self._get_queue_url,
            "GetQueueAttributes": self._get_queue_attributes,
            "SetQueueAttributes": self._set_queue_attributes,
            "ListQueues": self._list_queues,
            "PurgeQueue": self._purge_queue,
            "ListQueueTags": self._list_queue_tags,
            "TagQueue": self._tag_queue,
            "UntagQueue": self._untag_queue,
            "SendMessageBatch": self._send_message_batch,
            "DeleteMessageBatch": self._delete_message_batch,
            "ChangeMessageVisibility": self._change_message_visibility,
            "ChangeMessageVisibilityBatch": self._change_message_visibility_batch,
            "ListDeadLetterSourceQueues": self._list_dead_letter_source_queues,
        }

    def _json_handlers(self) -> dict:
        return {
            "SendMessage": self._json_send_message,
            "ReceiveMessage": self._json_receive_message,
            "DeleteMessage": self._json_delete_message,
            "CreateQueue": self._json_create_queue,
            "DeleteQueue": self._json_delete_queue,
            "GetQueueUrl": self._json_get_queue_url,
            "GetQueueAttributes": self._json_get_queue_attributes,
            "SetQueueAttributes": self._json_set_queue_attributes,
            "ListQueues": self._json_list_queues,
            "PurgeQueue": self._json_purge_queue,
            "ListQueueTags": self._json_list_queue_tags,
            "TagQueue": self._json_tag_queue,
            "UntagQueue": self._json_untag_queue,
            "SendMessageBatch": self._json_send_message_batch,
            "DeleteMessageBatch": self._json_delete_message_batch,
            "ChangeMessageVisibility": self._json_change_message_visibility,
            "ChangeMessageVisibilityBatch": self._json_change_message_visibility_batch,
            "ListDeadLetterSourceQueues": self._json_list_dead_letter_source_queues,
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
                now = time.monotonic()
                for msg_dict in messages:
                    # Find the underlying message and adjust
                    for m in queue.messages:
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

    async def _send_message_batch(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        successful: list[str] = []
        failed: list[str] = []

        n = 1
        while f"SendMessageBatchRequestEntry.{n}.Id" in params:
            entry_id = params[f"SendMessageBatchRequestEntry.{n}.Id"]
            msg_body = params.get(f"SendMessageBatchRequestEntry.{n}.MessageBody", "")
            delay = int(params.get(f"SendMessageBatchRequestEntry.{n}.DelaySeconds", "0"))

            try:
                message_id = await self.provider.send_message(
                    queue_name=queue_name,
                    message_body=msg_body,
                    delay_seconds=delay,
                )
                md5_body = hashlib.md5(msg_body.encode()).hexdigest()
                successful.append(
                    f"<SendMessageBatchResultEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"<MessageId>{message_id}</MessageId>"
                    f"<MD5OfMessageBody>{md5_body}</MD5OfMessageBody>"
                    f"</SendMessageBatchResultEntry>"
                )
            except Exception as exc:
                failed.append(
                    f"<BatchResultErrorEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"<SenderFault>true</SenderFault>"
                    f"<Code>InternalError</Code>"
                    f"<Message>{exc}</Message>"
                    f"</BatchResultErrorEntry>"
                )
            n += 1

        xml = (
            "<SendMessageBatchResponse>"
            "<SendMessageBatchResult>"
            f"{''.join(successful)}"
            f"{''.join(failed)}"
            "</SendMessageBatchResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</SendMessageBatchResponse>"
        )
        return _xml_response(xml)

    async def _delete_message_batch(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        successful: list[str] = []
        failed: list[str] = []

        n = 1
        while f"DeleteMessageBatchRequestEntry.{n}.Id" in params:
            entry_id = params[f"DeleteMessageBatchRequestEntry.{n}.Id"]
            receipt_handle = params.get(f"DeleteMessageBatchRequestEntry.{n}.ReceiptHandle", "")

            try:
                await self.provider.delete_message(queue_name, receipt_handle)
                successful.append(
                    f"<DeleteMessageBatchResultEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"</DeleteMessageBatchResultEntry>"
                )
            except Exception as exc:
                failed.append(
                    f"<BatchResultErrorEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"<SenderFault>true</SenderFault>"
                    f"<Code>InternalError</Code>"
                    f"<Message>{exc}</Message>"
                    f"</BatchResultErrorEntry>"
                )
            n += 1

        xml = (
            "<DeleteMessageBatchResponse>"
            "<DeleteMessageBatchResult>"
            f"{''.join(successful)}"
            f"{''.join(failed)}"
            "</DeleteMessageBatchResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</DeleteMessageBatchResponse>"
        )
        return _xml_response(xml)

    async def _change_message_visibility(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        receipt_handle = params.get("ReceiptHandle", "")
        visibility_timeout = int(params.get("VisibilityTimeout", "0"))

        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )

        now = time.monotonic()
        for msg in queue.messages:
            if msg.receipt_handle == receipt_handle:
                msg.visibility_timeout_until = now + visibility_timeout
                break

        xml = (
            "<ChangeMessageVisibilityResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ChangeMessageVisibilityResponse>"
        )
        return _xml_response(xml)

    async def _change_message_visibility_batch(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        successful: list[str] = []
        failed: list[str] = []

        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )

        now = time.monotonic()
        n = 1
        while f"ChangeMessageVisibilityBatchRequestEntry.{n}.Id" in params:
            entry_id = params[f"ChangeMessageVisibilityBatchRequestEntry.{n}.Id"]
            receipt_handle = params.get(
                f"ChangeMessageVisibilityBatchRequestEntry.{n}.ReceiptHandle", ""
            )
            vt = int(
                params.get(f"ChangeMessageVisibilityBatchRequestEntry.{n}.VisibilityTimeout", "0")
            )

            found = False
            for msg in queue.messages:
                if msg.receipt_handle == receipt_handle:
                    msg.visibility_timeout_until = now + vt
                    found = True
                    break

            if found:
                successful.append(
                    f"<ChangeMessageVisibilityBatchResultEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"</ChangeMessageVisibilityBatchResultEntry>"
                )
            else:
                failed.append(
                    f"<BatchResultErrorEntry>"
                    f"<Id>{entry_id}</Id>"
                    f"<SenderFault>true</SenderFault>"
                    f"<Code>ReceiptHandleIsInvalid</Code>"
                    f"<Message>The input receipt handle is invalid.</Message>"
                    f"</BatchResultErrorEntry>"
                )
            n += 1

        xml = (
            "<ChangeMessageVisibilityBatchResponse>"
            "<ChangeMessageVisibilityBatchResult>"
            f"{''.join(successful)}"
            f"{''.join(failed)}"
            "</ChangeMessageVisibilityBatchResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ChangeMessageVisibilityBatchResponse>"
        )
        return _xml_response(xml)

    async def _list_dead_letter_source_queues(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )

        source_queues: list[str] = []
        for name, q in self.provider.queues.items():
            if hasattr(q, "dead_letter_queue") and q.dead_letter_queue is queue:
                source_queues.append(name)

        urls_xml = "".join(
            f"<QueueUrl>{_queue_url(name)}</QueueUrl>" for name in sorted(source_queues)
        )
        xml = (
            "<ListDeadLetterSourceQueuesResponse>"
            "<ListDeadLetterSourceQueuesResult>"
            f"{urls_xml}"
            "</ListDeadLetterSourceQueuesResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ListDeadLetterSourceQueuesResponse>"
        )
        return _xml_response(xml)

    async def _create_queue(self, params: dict) -> Response:
        queue_name = params.get("QueueName", "")
        attrs = _extract_queue_attributes(params)
        config = build_queue_config(queue_name, attrs)
        self.provider.create_queue_from_config(config)

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

    async def _delete_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        try:
            await self.provider.delete_queue(queue_name)
        except KeyError:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )
        xml = (
            "<DeleteQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</DeleteQueueResponse>"
        )
        return _xml_response(xml)

    async def _list_queues(self, _params: dict) -> Response:
        queue_names = await self.provider.list_queues()
        urls_xml = "".join(f"<QueueUrl>{_queue_url(name)}</QueueUrl>" for name in queue_names)
        xml = (
            "<ListQueuesResponse>"
            "<ListQueuesResult>"
            f"{urls_xml}"
            "</ListQueuesResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ListQueuesResponse>"
        )
        return _xml_response(xml)

    async def _purge_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        try:
            await self.provider.purge_queue(queue_name)
        except KeyError:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )
        xml = (
            "<PurgeQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</PurgeQueueResponse>"
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
                now = time.monotonic()
                for msg_dict in messages:
                    for m in queue.messages:
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
        attrs = body.get("Attributes", {})
        config = build_queue_config(queue_name, attrs)
        self.provider.create_queue_from_config(config)
        return _json_response({"QueueUrl": _queue_url(queue_name)})

    async def _json_delete_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        try:
            await self.provider.delete_queue(queue_name)
        except KeyError:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({})

    async def _json_list_queues(self, _body: dict) -> Response:
        queue_names = await self.provider.list_queues()
        return _json_response(
            {
                "QueueUrls": [_queue_url(name) for name in queue_names],
            }
        )

    async def _json_purge_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        try:
            await self.provider.purge_queue(queue_name)
        except KeyError:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({})

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
        config = self.provider.configs.get(queue_name)
        return _json_response({"Attributes": _build_queue_attrs(queue_name, queue, config)})

    async def _json_set_queue_attributes(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        attrs = body.get("Attributes", {})
        config = self.provider.configs.get(queue_name)
        _apply_queue_attrs(queue, attrs, config)
        return _json_response({})

    async def _json_list_queue_tags(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)
        tags = config.tags if config else {}
        return _json_response({"Tags": tags})

    async def _json_tag_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)
        if config:
            config.tags.update(body.get("Tags", {}))
        return _json_response({})

    async def _json_untag_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)
        if config:
            for key in body.get("TagKeys", []):
                config.tags.pop(key, None)
        return _json_response({})

    async def _json_send_message_batch(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        entries = body.get("Entries", [])
        successful: list[dict] = []
        failed: list[dict] = []

        for entry in entries:
            entry_id = entry.get("Id", "")
            msg_body = entry.get("MessageBody", "")
            delay = int(entry.get("DelaySeconds", 0))

            try:
                message_id = await self.provider.send_message(
                    queue_name=queue_name,
                    message_body=msg_body,
                    delay_seconds=delay,
                )
                md5_body = hashlib.md5(msg_body.encode()).hexdigest()
                successful.append(
                    {
                        "Id": entry_id,
                        "MessageId": message_id,
                        "MD5OfMessageBody": md5_body,
                    }
                )
            except Exception as exc:
                failed.append(
                    {
                        "Id": entry_id,
                        "SenderFault": True,
                        "Code": "InternalError",
                        "Message": str(exc),
                    }
                )

        return _json_response({"Successful": successful, "Failed": failed})

    async def _json_delete_message_batch(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        entries = body.get("Entries", [])
        successful: list[dict] = []
        failed: list[dict] = []

        for entry in entries:
            entry_id = entry.get("Id", "")
            receipt_handle = entry.get("ReceiptHandle", "")

            try:
                await self.provider.delete_message(queue_name, receipt_handle)
                successful.append({"Id": entry_id})
            except Exception as exc:
                failed.append(
                    {
                        "Id": entry_id,
                        "SenderFault": True,
                        "Code": "InternalError",
                        "Message": str(exc),
                    }
                )

        return _json_response({"Successful": successful, "Failed": failed})

    async def _json_change_message_visibility(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        receipt_handle = body.get("ReceiptHandle", "")
        visibility_timeout = int(body.get("VisibilityTimeout", 0))

        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )

        now = time.monotonic()
        for msg in queue.messages:
            if msg.receipt_handle == receipt_handle:
                msg.visibility_timeout_until = now + visibility_timeout
                break

        return _json_response({})

    async def _json_change_message_visibility_batch(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        entries = body.get("Entries", [])

        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )

        successful: list[dict] = []
        failed: list[dict] = []
        now = time.monotonic()

        for entry in entries:
            entry_id = entry.get("Id", "")
            receipt_handle = entry.get("ReceiptHandle", "")
            vt = int(entry.get("VisibilityTimeout", 0))

            found = False
            for msg in queue.messages:
                if msg.receipt_handle == receipt_handle:
                    msg.visibility_timeout_until = now + vt
                    found = True
                    break

            if found:
                successful.append({"Id": entry_id})
            else:
                failed.append(
                    {
                        "Id": entry_id,
                        "SenderFault": True,
                        "Code": "ReceiptHandleIsInvalid",
                        "Message": "The input receipt handle is invalid.",
                    }
                )

        return _json_response({"Successful": successful, "Failed": failed})

    async def _json_list_dead_letter_source_queues(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )

        source_queues: list[str] = []
        for name, q in self.provider.queues.items():
            if hasattr(q, "dead_letter_queue") and q.dead_letter_queue is queue:
                source_queues.append(name)

        return _json_response({"QueueUrls": [_queue_url(name) for name in sorted(source_queues)]})

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

        config = self.provider.configs.get(queue_name)
        attrs = _build_queue_attrs(queue_name, queue, config)
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

    async def _set_queue_attributes(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        queue = self.provider.get_queue(queue_name)
        if queue is None:
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
                status_code=400,
            )
        attrs = _extract_queue_attributes(params)
        config = self.provider.configs.get(queue_name)
        _apply_queue_attrs(queue, attrs, config)
        xml = (
            "<SetQueueAttributesResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</SetQueueAttributesResponse>"
        )
        return _xml_response(xml)

    async def _list_queue_tags(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        config = self.provider.configs.get(queue_name)
        tags = config.tags if config else {}
        tags_xml = "".join(
            f"<entry><key>{k}</key><value>{v}</value></entry>" for k, v in tags.items()
        )
        xml = (
            "<ListQueueTagsResponse>"
            "<ListQueueTagsResult>"
            f"{tags_xml}"
            "</ListQueueTagsResult>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</ListQueueTagsResponse>"
        )
        return _xml_response(xml)

    async def _tag_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        config = self.provider.configs.get(queue_name)
        if config:
            tags = _extract_queue_tags(params)
            config.tags.update(tags)
        xml = (
            "<TagQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</TagQueueResponse>"
        )
        return _xml_response(xml)

    async def _untag_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        config = self.provider.configs.get(queue_name)
        if config:
            n = 1
            while f"TagKey.{n}" in params:
                config.tags.pop(params[f"TagKey.{n}"], None)
                n += 1
        xml = (
            "<UntagQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</UntagQueueResponse>"
        )
        return _xml_response(xml)


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _build_queue_attrs(
    queue_name: str, queue: object, config: QueueConfig | None = None
) -> dict[str, str]:
    """Build the full set of queue attributes that Terraform expects."""

    now_ts = str(int(time.time()))
    # Start with defaults
    attrs: dict[str, str] = {
        "QueueArn": f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{queue_name}",
        "ApproximateNumberOfMessages": str(len(queue.messages)),  # type: ignore[attr-defined]
        "ApproximateNumberOfMessagesNotVisible": "0",
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


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_sqs_app(
    provider: SqsProvider,
    port: int = 4566,
    chaos: AwsChaosConfig | None = None,
    aws_mock: AwsMockConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the SQS wire protocol."""
    global _sqs_port  # noqa: PLW0603
    _sqs_port = port
    app = FastAPI()
    if aws_mock is not None:
        app.add_middleware(AwsOperationMockMiddleware, mock_config=aws_mock, service="sqs")
    add_iam_auth_middleware(app, "sqs", iam_auth, ErrorFormat.XML_IAM)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sqs")
    sqs_router = SqsRouter(provider)
    app.include_router(sqs_router.router)
    return app
