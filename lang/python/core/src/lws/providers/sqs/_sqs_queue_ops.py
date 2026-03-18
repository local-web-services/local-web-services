"""XML/query-string protocol handlers for SQS queue CRUD operations."""

from __future__ import annotations

import uuid

from fastapi import Response

from lws.providers.sqs._sqs_helpers import (
    _apply_queue_attrs,
    _build_queue_attrs,
    _do_delete_queue,
    _error_xml,
    _extract_queue_attributes,
    _extract_queue_name,
    _extract_queue_tags,
    _get_queue_or_error_xml,
    _nonexistent_queue_error_xml,
    _queue_url,
    _xml_response,
)
from lws.providers.sqs.provider import build_queue_config


class _SqsQueueOpsMixin:
    """Mixin providing queue CRUD XML handlers for ``SqsRouter``.

    Expects the host class to provide:
    - ``self.provider``   — ``SqsProvider``
    - ``self._lifecycle`` — ``ResourceLifecycleConfig``
    - ``self._tracker``   — ``ResourceStateTracker``
    """

    async def _create_queue(self, params: dict) -> Response:
        queue_name = params.get("QueueName", "")
        attrs = _extract_queue_attributes(params)
        config = build_queue_config(queue_name, attrs)
        if self.provider.get_queue(queue_name) is not None:  # type: ignore[attr-defined]
            return _error_xml(
                "QueueAlreadyExists",
                f"A queue with the name {queue_name!r} already exists.",
                status_code=400,
            )
        self.provider.create_queue_from_config(config)  # type: ignore[attr-defined]
        if self._lifecycle.enabled and self._lifecycle.create_dwell_ms > 0:  # type: ignore[attr-defined]
            self._tracker.set_state(queue_name, "CREATING")  # type: ignore[attr-defined]
            self._tracker.schedule_transition(queue_name, "ACTIVE", self._lifecycle.create_dwell_ms)  # type: ignore[attr-defined]

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
        state = self._tracker.get_state(queue_name)  # type: ignore[attr-defined]
        if state == "CREATING" and self._lifecycle.enabled:  # type: ignore[attr-defined]
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"Queue {queue_name} is still being created",
                status_code=400,
            )
        try:
            await _do_delete_queue(self.provider, self._tracker, self._lifecycle, queue_name)  # type: ignore[attr-defined]
        except KeyError:
            return _nonexistent_queue_error_xml(queue_name)
        xml = (
            "<DeleteQueueResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</DeleteQueueResponse>"
        )
        return _xml_response(xml)

    async def _get_queue_url(self, params: dict) -> Response:
        queue_name = params.get("QueueName", "")
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        _queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err

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

    async def _get_queue_attributes(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err

        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
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
        err = self._get_lifecycle_error_xml(queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        queue, err = _get_queue_or_error_xml(self.provider, queue_name)  # type: ignore[attr-defined]
        if err is not None:
            return err
        attrs = _extract_queue_attributes(params)
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
        _apply_queue_attrs(queue, attrs, config)
        xml = (
            "<SetQueueAttributesResponse>"
            f"<ResponseMetadata><RequestId>{uuid.uuid4()}</RequestId></ResponseMetadata>"
            "</SetQueueAttributesResponse>"
        )
        return _xml_response(xml)

    async def _list_queues(self, _params: dict) -> Response:
        queue_names = await self.provider.list_queues()  # type: ignore[attr-defined]
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

    async def _tag_queue(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
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
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
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

    async def _list_queue_tags(self, params: dict) -> Response:
        queue_name = _extract_queue_name(params)
        config = self.provider.configs.get(queue_name)  # type: ignore[attr-defined]
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
