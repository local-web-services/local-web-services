"""SQS event-source poller for Lambda integration.

Polls SQS queues at a configurable interval and invokes Lambda handlers
with SQS-format event batches, emulating the AWS Lambda SQS event-source
mapping behaviour.
"""

from __future__ import annotations

import asyncio
import logging
import uuid
from dataclasses import dataclass

from ldk.interfaces.compute import ICompute, InvocationResult, LambdaContext
from ldk.interfaces.queue import IQueue

logger = logging.getLogger(__name__)


@dataclass
class EventSourceMapping:
    """Maps an SQS queue to a Lambda function."""

    queue_name: str
    function_name: str
    batch_size: int = 10
    enabled: bool = True


class SqsEventSourcePoller:
    """Polls SQS queues and invokes Lambda functions with event batches.

    Parameters
    ----------
    queue_provider:
        The ``IQueue`` provider to receive messages from.
    compute_providers:
        A mapping of function names to ``ICompute`` providers.
    mappings:
        A list of ``EventSourceMapping`` configurations.
    poll_interval:
        Base polling interval in seconds.
    max_backoff:
        Maximum backoff interval in seconds when queues are empty.
    """

    def __init__(
        self,
        queue_provider: IQueue,
        compute_providers: dict[str, ICompute],
        mappings: list[EventSourceMapping],
        poll_interval: float = 1.0,
        max_backoff: float = 20.0,
    ) -> None:
        self._queue_provider = queue_provider
        self._compute_providers = compute_providers
        self._mappings = mappings
        self._poll_interval = poll_interval
        self._max_backoff = max_backoff
        self._tasks: list[asyncio.Task] = []
        self._running = False

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    async def start(self) -> None:
        """Start polling tasks for each enabled mapping."""
        self._running = True
        for mapping in self._mappings:
            if mapping.enabled:
                task = asyncio.create_task(
                    self._poll_loop(mapping),
                    name=f"sqs-poller-{mapping.queue_name}",
                )
                self._tasks.append(task)

    async def stop(self) -> None:
        """Cancel all polling tasks and wait for them to finish."""
        self._running = False
        for task in self._tasks:
            task.cancel()
        if self._tasks:
            await asyncio.gather(*self._tasks, return_exceptions=True)
        self._tasks.clear()

    # ------------------------------------------------------------------
    # Polling loop
    # ------------------------------------------------------------------

    async def _poll_loop(self, mapping: EventSourceMapping) -> None:
        """Continuously poll a queue and invoke the mapped function."""
        backoff = self._poll_interval

        while self._running:
            try:
                messages = await self._queue_provider.receive_messages(
                    queue_name=mapping.queue_name,
                    max_messages=mapping.batch_size,
                )

                if not messages:
                    backoff = min(backoff * 2, self._max_backoff)
                    await asyncio.sleep(backoff)
                    continue

                # Reset backoff on successful receive
                backoff = self._poll_interval

                result = await self._invoke_function(mapping, messages)
                await self._handle_result(mapping, messages, result)

            except asyncio.CancelledError:
                break
            except Exception:
                logger.exception(
                    "Error polling queue %s for function %s",
                    mapping.queue_name,
                    mapping.function_name,
                )
                await asyncio.sleep(backoff)

    # ------------------------------------------------------------------
    # Invocation
    # ------------------------------------------------------------------

    async def _invoke_function(
        self,
        mapping: EventSourceMapping,
        messages: list[dict],
    ) -> InvocationResult:
        """Build an SQS event and invoke the Lambda function."""
        compute = self._compute_providers.get(mapping.function_name)
        if compute is None:
            raise KeyError(f"Compute provider not found: {mapping.function_name}")

        event = _build_sqs_event(messages, mapping.queue_name)
        context = LambdaContext(
            function_name=mapping.function_name,
            memory_limit_in_mb=128,
            timeout_seconds=30,
            aws_request_id=str(uuid.uuid4()),
            invoked_function_arn=(
                f"arn:aws:lambda:us-east-1:000000000000:function:{mapping.function_name}"
            ),
        )

        return await compute.invoke(event, context)

    async def _handle_result(
        self,
        mapping: EventSourceMapping,
        messages: list[dict],
        result: InvocationResult,
    ) -> None:
        """Delete successfully processed messages or leave them for retry."""
        if result.error is None:
            # Success -- delete all messages
            for msg in messages:
                receipt_handle = msg.get("ReceiptHandle", "")
                if receipt_handle:
                    await self._queue_provider.delete_message(
                        mapping.queue_name,
                        receipt_handle,
                    )
        else:
            # Failure -- messages will become visible again after timeout
            logger.warning(
                "Function %s failed for queue %s: %s",
                mapping.function_name,
                mapping.queue_name,
                result.error,
            )


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _build_sqs_event(messages: list[dict], queue_name: str) -> dict:
    """Build an SQS Lambda event from a list of received messages."""
    records = []
    for msg in messages:
        records.append(
            {
                "messageId": msg.get("MessageId", ""),
                "receiptHandle": msg.get("ReceiptHandle", ""),
                "body": msg.get("Body", ""),
                "attributes": msg.get("Attributes", {}),
                "messageAttributes": msg.get("MessageAttributes", {}),
                "md5OfBody": msg.get("MD5OfBody", ""),
                "eventSource": "aws:sqs",
                "eventSourceARN": (f"arn:aws:sqs:us-east-1:000000000000:{queue_name}"),
                "awsRegion": "us-east-1",
            }
        )
    return {"Records": records}
