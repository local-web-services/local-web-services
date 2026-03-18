"""EventSourceManager — activates event source mappings at runtime.

Coordinates between queue providers (SQS) and stream dispatchers
(DynamoDB Streams) to invoke Lambda functions when events arrive.
"""

from __future__ import annotations

import logging
from typing import Any

from lws.interfaces.compute import ICompute
from lws.interfaces.queue import IQueue
from lws.providers._shared.lambda_helpers import build_default_lambda_context
from lws.providers.dynamodb.streams import StreamDispatcher
from lws.providers.sqs.event_source import EventSourceMapping, SqsEventSourcePoller

logger = logging.getLogger(__name__)


class EventSourceManager:
    """Manages activation and deactivation of event source mappings.

    Parameters
    ----------
    queue_providers : dict[str, IQueue]
        Map of queue name to IQueue provider.
    stream_dispatchers : dict[str, StreamDispatcher]
        Map of table name to StreamDispatcher.
    compute_providers : dict[str, ICompute]
        Map of function name to ICompute provider.
    """

    def __init__(
        self,
        queue_providers: dict[str, IQueue],
        stream_dispatchers: dict[str, StreamDispatcher],
        compute_providers: dict[str, ICompute],
    ) -> None:
        self._queue_providers = queue_providers
        self._stream_dispatchers = stream_dispatchers
        self._compute_providers = compute_providers
        self._active_pollers: dict[str, SqsEventSourcePoller] = {}
        self._active_stream_handlers: dict[str, tuple[str, Any]] = {}

    async def activate(self, mapping: dict[str, Any]) -> None:
        """Activate an event source mapping based on its EventSourceArn."""
        esm_uuid = mapping.get("UUID", "")
        event_source_arn = mapping.get("EventSourceArn", "")
        function_ref = mapping.get("FunctionArn", "") or mapping.get("FunctionName", "")
        batch_size = mapping.get("BatchSize", 10)

        # Extract function name from ARN if needed
        function_name = _extract_function_name(function_ref)

        if ":sqs:" in event_source_arn:
            await self._activate_sqs(esm_uuid, event_source_arn, function_name, batch_size)
        elif ":dynamodb:" in event_source_arn and "/stream" in event_source_arn:
            self._activate_dynamodb_stream(esm_uuid, event_source_arn, function_name)
        else:
            logger.warning("Unsupported event source ARN: %s", event_source_arn)

    async def deactivate(self, esm_uuid: str) -> None:
        """Deactivate an event source mapping by UUID."""
        if esm_uuid in self._active_pollers:
            poller = self._active_pollers.pop(esm_uuid)
            await poller.stop()
            logger.info("Stopped SQS poller for mapping %s", esm_uuid)

        if esm_uuid in self._active_stream_handlers:
            self._active_stream_handlers.pop(esm_uuid)
            logger.info("Removed stream handler for mapping %s", esm_uuid)

    async def stop_all(self) -> None:
        """Stop all active pollers and handlers."""
        for esm_uuid in list(self._active_pollers):
            poller = self._active_pollers.pop(esm_uuid)
            await poller.stop()
        self._active_stream_handlers.clear()

    async def _activate_sqs(
        self,
        esm_uuid: str,
        event_source_arn: str,
        function_name: str,
        batch_size: int,
    ) -> None:
        """Activate an SQS event source mapping."""
        queue_name = _extract_queue_name(event_source_arn)
        queue_provider = self._queue_providers.get(queue_name)
        if queue_provider is None:
            logger.warning("Queue provider not found for %s", queue_name)
            return

        compute = self._compute_providers.get(function_name)
        if compute is None:
            logger.warning("Compute provider not found for %s", function_name)
            return

        mapping = EventSourceMapping(
            queue_name=queue_name,
            function_name=function_name,
            batch_size=batch_size,
        )
        poller = SqsEventSourcePoller(
            queue_provider=queue_provider,
            compute_providers={function_name: compute},
            mappings=[mapping],
        )
        await poller.start()
        self._active_pollers[esm_uuid] = poller
        logger.info("Activated SQS event source: %s -> %s", queue_name, function_name)

    def _activate_dynamodb_stream(
        self,
        esm_uuid: str,
        event_source_arn: str,
        function_name: str,
    ) -> None:
        """Activate a DynamoDB Streams event source mapping."""
        table_name = _extract_table_name(event_source_arn)
        dispatcher = self._stream_dispatchers.get(table_name)
        if dispatcher is None:
            logger.warning("Stream dispatcher not found for table %s", table_name)
            return

        compute = self._compute_providers.get(function_name)
        if compute is None:
            logger.warning("Compute provider not found for %s", function_name)
            return

        async def handler(event: dict) -> None:
            context = build_default_lambda_context(function_name)
            await compute.invoke(event, context)

        dispatcher.register_handler(table_name, handler)
        self._active_stream_handlers[esm_uuid] = (table_name, handler)
        logger.info("Activated DynamoDB stream: %s -> %s", table_name, function_name)


def _extract_function_name(function_ref: str) -> str:
    """Extract function name from an ARN or return the string as-is."""
    if function_ref.startswith("arn:"):
        parts = function_ref.split(":")
        return parts[-1] if parts else function_ref
    return function_ref


def _extract_queue_name(arn: str) -> str:
    """Extract queue name from an SQS ARN."""
    # arn:aws:sqs:region:account:queue-name
    parts = arn.split(":")
    return parts[-1] if len(parts) >= 6 else arn


def _extract_table_name(arn: str) -> str:
    """Extract table name from a DynamoDB Streams ARN."""
    # arn:aws:dynamodb:region:account:table/TABLE_NAME/stream/...
    if "table/" in arn:
        after_table = arn.split("table/", 1)[1]
        return after_table.split("/")[0]
    return arn
