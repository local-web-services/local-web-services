"""JSON 1.0 protocol handler mixin for SQS."""

from __future__ import annotations

import hashlib
import time

from fastapi import Response

from lws.providers.sqs._sqs_helpers import (
    _apply_queue_attrs,
    _apply_visibility_timeout_to_messages,
    _build_queue_attrs,
    _do_delete_queue,
    _extract_queue_name_from_url,
    _find_and_update_visibility,
    _json_error,
    _json_response,
    _queue_url,
    _send_message_and_get_md5,
)
from lws.providers.sqs.provider import build_queue_config


class _SqsJsonHandlersMixin:
    """Mixin providing AWS JSON 1.0 protocol handlers for ``SqsRouter``.

    Expects the host class to provide:
    - ``self.provider``   — ``SqsProvider``
    - ``self._lifecycle`` — ``ResourceLifecycleConfig``
    - ``self._tracker``   — ``ResourceStateTracker``
    """

    async def _json_send_message(self, body: dict) -> Response:
        if self._capacity.is_exhausted:  # type: ignore[attr-defined]
            return _json_error(
                "ServiceUnavailableException",
                "lws: no message slots available",
            )
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        if self.provider.get_queue(queue_name) is None:  # type: ignore[attr-defined]
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        msg_body = body.get("MessageBody", "")
        delay = int(body.get("DelaySeconds", 0))
        message_attributes = body.get("MessageAttributes", {})

        message_id = await self.provider.send_message(  # type: ignore[attr-defined]
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

    def _apply_visibility_timeout(
        self, queue_name: str, messages: list, visibility_timeout: str
    ) -> None:
        """Update in-flight visibility timeouts for received messages."""
        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
        if queue is None:
            return
        _apply_visibility_timeout_to_messages(queue, messages, visibility_timeout)

    async def _json_receive_message(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        if self.provider.get_queue(queue_name) is None:  # type: ignore[attr-defined]
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        max_messages = int(body.get("MaxNumberOfMessages", 1))
        wait_time = int(body.get("WaitTimeSeconds", 0))
        visibility_timeout = body.get("VisibilityTimeout")

        messages = await self.provider.receive_messages(  # type: ignore[attr-defined]
            queue_name=queue_name,
            max_messages=max_messages,
            wait_time_seconds=wait_time,
        )

        if visibility_timeout is not None:
            self._apply_visibility_timeout(queue_name, messages, visibility_timeout)

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
        await self.provider.delete_message(queue_name, receipt_handle)  # type: ignore[attr-defined]
        return _json_response({})

    async def _json_create_queue(self, body: dict) -> Response:
        queue_name = body.get("QueueName", "")
        attrs = body.get("Attributes", {})
        config = build_queue_config(queue_name, attrs)
        if self.provider.get_queue(queue_name) is not None:  # type: ignore[attr-defined]
            return _json_error(
                "QueueAlreadyExists",
                f"A queue with the name {queue_name!r} already exists.",
            )
        self.provider.create_queue_from_config(config)  # type: ignore[attr-defined]
        if self._lifecycle.enabled and self._lifecycle.create_dwell_ms > 0:  # type: ignore[attr-defined]
            self._tracker.set_state(queue_name, "CREATING")  # type: ignore[attr-defined]
            self._tracker.schedule_transition(queue_name, "ACTIVE", self._lifecycle.create_dwell_ms)  # type: ignore[attr-defined]
        return _json_response({"QueueUrl": _queue_url(queue_name)})

    async def _json_delete_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        state = self._tracker.get_state(queue_name)  # type: ignore[attr-defined]
        if state == "CREATING" and self._lifecycle.enabled:  # type: ignore[attr-defined]
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"Queue {queue_name} is still being created",
            )
        try:
            await _do_delete_queue(self.provider, self._tracker, self._lifecycle, queue_name)  # type: ignore[attr-defined]
        except KeyError:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({})

    async def _json_list_queues(self, _body: dict) -> Response:
        queue_names = await self.provider.list_queues()  # type: ignore[attr-defined]
        return _json_response(
            {
                "QueueUrls": [_queue_url(name) for name in queue_names],
            }
        )

    async def _json_purge_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        try:
            await self.provider.purge_queue(queue_name)  # type: ignore[attr-defined]
        except KeyError:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({})

    async def _json_get_queue_url(self, body: dict) -> Response:
        queue_name = body.get("QueueName", "")
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        return _json_response({"QueueUrl": _queue_url(queue_name)})

    async def _json_get_queue_attributes(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
        return _json_response({"Attributes": _build_queue_attrs(queue_name, queue, config)})

    async def _json_set_queue_attributes(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )
        attrs = body.get("Attributes", {})
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
        if "RedrivePolicy" in attrs:
            existing_policy = (config.custom_attrs.get("RedrivePolicy") if config else None) or (
                queue.dead_letter_queue is not None  # type: ignore[attr-defined]
            )
            if existing_policy:
                return _json_error(
                    "InvalidParameterValue",
                    "A dead-letter queue is already configured for this queue.",
                    status_code=400,
                )
            import json as _json_lib

            try:
                redrive = _json_lib.loads(attrs["RedrivePolicy"])
                dlq_arn = redrive.get("deadLetterTargetArn", "")
                dlq_name = dlq_arn.split(":")[-1] if ":" in dlq_arn else dlq_arn
            except (ValueError, KeyError):
                dlq_name = ""
            if dlq_name:
                dlq = self.provider.get_queue(dlq_name)  # type: ignore[attr-defined]
                if dlq is None:
                    return _json_error(
                        "InvalidParameterValue",
                        f"Value {dlq_arn!r} for parameter RedrivePolicy is invalid. "
                        "Reason: Dead letter target does not exist.",
                        status_code=400,
                    )
                dlq_state = self._get_lifecycle_error_json(dlq_name)  # type: ignore[attr-defined]
                if dlq_state is not None:
                    return _json_error(
                        "InvalidParameterValue",
                        f"Value {dlq_arn!r} for parameter RedrivePolicy is invalid. "
                        "Reason: Dead letter target is not ACTIVE.",
                        status_code=400,
                    )
        _apply_queue_attrs(queue, attrs, config)
        return _json_response({})

    async def _json_list_queue_tags(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
        tags = config.tags if config else {}
        return _json_response({"Tags": tags})

    async def _json_tag_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
        if config:
            config.tags.update(body.get("Tags", {}))
        return _json_response({})

    async def _json_untag_queue(self, body: dict) -> Response:
        queue_name = _extract_queue_name_from_url(body.get("QueueUrl", ""))
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
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
                message_id, md5_body = await _send_message_and_get_md5(
                    self.provider, queue_name, msg_body, delay  # type: ignore[attr-defined]
                )
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
                await self.provider.delete_message(queue_name, receipt_handle)  # type: ignore[attr-defined]
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
        err = self._get_lifecycle_error_json(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        receipt_handle = body.get("ReceiptHandle", "")
        visibility_timeout = int(body.get("VisibilityTimeout", 0))

        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
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

        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
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

            found = _find_and_update_visibility(queue, receipt_handle, vt, now)

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
        queue = self.provider.get_queue(queue_name)  # type: ignore[attr-defined]
        if queue is None:
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name}",
            )

        source_queues: list[str] = []
        for name, q in self.provider.queues.items():  # type: ignore[attr-defined]
            if hasattr(q, "dead_letter_queue") and q.dead_letter_queue is queue:
                source_queues.append(name)

        return _json_response({"QueueUrls": [_queue_url(name) for name in sorted(source_queues)]})
