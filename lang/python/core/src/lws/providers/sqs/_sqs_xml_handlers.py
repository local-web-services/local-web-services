"""XML/query-string protocol handler mixin for SQS."""

from __future__ import annotations

import hashlib
import time
import uuid

from fastapi import Response

from lws.providers.sqs._sqs_helpers import (
    _apply_visibility_timeout_to_messages,
    _build_attributes_xml,
    _build_message_attributes_xml,
    _error_xml,
    _extract_message_attributes,
    _extract_queue_name,
    _find_and_update_visibility,
    _get_queue_or_error_xml,
    _nonexistent_queue_error_xml,
    _queue_url,
    _send_message_and_get_md5,
    _xml_response,
)
from lws.providers.sqs._sqs_queue_ops import _SqsQueueOpsMixin


class _SqsXmlHandlersMixin(_SqsQueueOpsMixin):
    """Mixin providing XML (query-string) protocol handlers for ``SqsRouter``.

    Expects the host class to provide:
    - ``self.provider``   — ``SqsProvider``
    - ``self._lifecycle`` — ``ResourceLifecycleConfig``
    - ``self._tracker``   — ``ResourceStateTracker``

    Queue CRUD operations are inherited from ``_SqsQueueOpsMixin``.
    """

    async def _send_message(self, params: dict) -> Response:
        if self._capacity.is_exhausted:  # type: ignore[attr-defined]
            return _error_xml(
                "OverLimit",
                "lws: no message slots available",
                400,
            )
        queue_name = _extract_queue_name(params)
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        body = params.get("MessageBody", "")
        delay = int(params.get("DelaySeconds", "0"))

        message_attributes = _extract_message_attributes(params)

        message_id = await self.provider.send_message(  # type: ignore[attr-defined]
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
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        max_messages = int(params.get("MaxNumberOfMessages", "1"))
        wait_time = int(params.get("WaitTimeSeconds", "0"))
        visibility_timeout = params.get("VisibilityTimeout")

        messages = await self.provider.receive_messages(  # type: ignore[attr-defined]
            queue_name=queue_name,
            max_messages=max_messages,
            wait_time_seconds=wait_time,
        )

        # Apply per-request visibility timeout override if provided
        if visibility_timeout is not None:
            queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
            if queue is not None:
                _apply_visibility_timeout_to_messages(queue, messages, visibility_timeout)

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

        await self.provider.delete_message(queue_name, receipt_handle)  # type: ignore[attr-defined]

        xml = (
            "<DeleteMessageResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</DeleteMessageResponse>"
        )
        return _xml_response(xml)

    async def _change_message_visibility(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        receipt_handle = params.get("ReceiptHandle", "")
        visibility_timeout = int(params.get("VisibilityTimeout", "0"))

        queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err

        _find_and_update_visibility(queue, receipt_handle, visibility_timeout, time.monotonic())

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

        queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err

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

            found = _find_and_update_visibility(queue, receipt_handle, vt, now)

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

    async def _purge_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        try:
            await self.provider.purge_queue(queue_name)  # type: ignore[attr-defined]
        except KeyError:
            return _nonexistent_queue_error_xml(queue_name)
        xml = (
            "<PurgeQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</PurgeQueueResponse>"
        )
        return _xml_response(xml)

    async def _send_message_batch(self, params: dict) -> Response:
        if self._capacity.is_exhausted:  # type: ignore[attr-defined]
            return _error_xml(
                "OverLimit",
                "lws: no message slots available",
                400,
            )
        queue_name = _extract_queue_name(params)
        successful: list[str] = []
        failed: list[str] = []

        n = 1
        while f"SendMessageBatchRequestEntry.{n}.Id" in params:
            entry_id = params[f"SendMessageBatchRequestEntry.{n}.Id"]
            msg_body = params.get(f"SendMessageBatchRequestEntry.{n}.MessageBody", "")
            delay = int(params.get(f"SendMessageBatchRequestEntry.{n}.DelaySeconds", "0"))

            try:
                message_id, md5_body = await _send_message_and_get_md5(
                    self.provider, queue_name, msg_body, delay  # type: ignore[attr-defined]
                )
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
                await self.provider.delete_message(queue_name, receipt_handle)  # type: ignore[attr-defined]
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

    async def _list_dead_letter_source_queues(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err

        source_queues: list[str] = []
        for name, q in self.provider.queues.items():  # type: ignore[attr-defined]
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
