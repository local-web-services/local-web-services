"""SQS wire-protocol HTTP server.

Implements both the legacy SQS query-string / form-body protocol and
the AWS JSON 1.0 protocol (``X-Amz-Target: AmazonSQS.*``) that newer
AWS SDKs use.
"""

from __future__ import annotations

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.provider_context import ProviderContext
from lws.providers.sqs._sqs_helpers import (
    _apply_queue_attrs,
    _build_attributes_xml,
    _build_message_attributes_xml,
    _build_queue_attrs,
    _error_xml,
    _extract_message_attributes,
    _extract_params,
    _extract_queue_attributes,
    _extract_queue_name,
    _extract_queue_name_from_path,
    _extract_queue_name_from_url,
    _extract_queue_tags,
    _json_error,
    _json_response,
    _queue_url,
    _xml_response,
)
from lws.providers.sqs._sqs_json_handlers import _SqsJsonHandlersMixin
from lws.providers.sqs._sqs_xml_handlers import _SqsXmlHandlersMixin
from lws.providers.sqs.provider import SqsProvider

_logger = get_logger("ldk.sqs")

# Re-export helpers so existing imports of these names from this module continue to work.
__all__ = [
    "_apply_queue_attrs",
    "_build_attributes_xml",
    "_build_message_attributes_xml",
    "_build_queue_attrs",
    "_error_xml",
    "_extract_message_attributes",
    "_extract_params",
    "_extract_queue_attributes",
    "_extract_queue_name",
    "_extract_queue_name_from_path",
    "_extract_queue_name_from_url",
    "_extract_queue_tags",
    "_json_error",
    "_json_response",
    "_queue_url",
    "_xml_response",
    "SqsRouter",
    "create_sqs_app",
]


class SqsRouter(_SqsXmlHandlersMixin, _SqsJsonHandlersMixin):
    """Route SQS wire-protocol requests to an ``SqsProvider`` backend."""

    def __init__(
        self,
        provider: SqsProvider,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
    ) -> None:
        self.provider = provider
        self._lifecycle = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lifecycle)
        self._capacity = capacity or AwsCapacityConfig()
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
    # Lifecycle helpers
    # ------------------------------------------------------------------

    def _get_lifecycle_error_xml(self, queue_name: str) -> Response | None:
        """Return an XML error if the queue is in a non-operable lifecycle state."""
        if not self._lifecycle.enabled:
            return None
        state = self._tracker.get_state(queue_name)
        if state in ("CREATING", "DELETING"):
            return _error_xml(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name} (status: {state})",
                status_code=400,
            )
        return None

    def _get_lifecycle_error_json(self, queue_name: str) -> Response | None:
        """Return a JSON error if the queue is in a non-operable lifecycle state."""
        if not self._lifecycle.enabled:
            return None
        state = self._tracker.get_state(queue_name)
        if state in ("CREATING", "DELETING"):
            return _json_error(
                "AWS.SimpleQueueService.NonExistentQueue",
                f"The specified queue does not exist: {queue_name} (status: {state})",
            )
        return None


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_sqs_app(
    provider: SqsProvider,
    port: int = 4566,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    tracker_ref: list[ResourceStateTracker] | None = None,
    capacity: AwsCapacityConfig | None = None,
    context: ProviderContext | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the SQS wire protocol.

    Args:
        tracker_ref: Optional single-element list; if provided, the lifecycle
            ``ResourceStateTracker`` used by this app is deposited at index 0
            so callers can share it with other services (e.g. EventBridge, SNS).
        capacity: Optional capacity configuration for slot-limit enforcement.
    """
    import lws.providers.sqs._sqs_helpers as _helpers  # noqa: PLC0415  # pylint: disable=import-outside-toplevel

    _helpers._sqs_port = port  # noqa: SLF001  # pylint: disable=protected-access
    app = FastAPI()
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="sqs")
    add_iam_auth_middleware(app, "sqs", iam_auth, ErrorFormat.XML_IAM)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sqs")
    sqs_router = SqsRouter(provider, lifecycle=lifecycle, capacity=capacity)
    if tracker_ref is not None:
        tracker_ref.append(sqs_router._tracker)  # noqa: SLF001  # pylint: disable=protected-access
    app.include_router(sqs_router.router)
    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "sqs")
    return app
