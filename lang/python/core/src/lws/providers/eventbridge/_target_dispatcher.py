"""Target dispatch helpers for the EventBridge provider.

Contains the TargetDispatcher class that routes matched rule targets
to SQS queues, SNS topics, Step Functions state machines, or Lambda
compute providers.
"""

from __future__ import annotations

import json
import logging
import uuid

from lws.interfaces.compute import ICompute, LambdaContext
from lws.interfaces.queue import IQueue
from lws.interfaces.state_machine import IStateMachine
from lws.providers.eventbridge._eventbridge_state import (
    RuleTarget,
    _extract_function_name,
)

logger = logging.getLogger(__name__)


class TargetDispatcher:
    """Dispatches a matched EventBridge event to a single rule target.

    Parameters
    ----------
    compute_providers:
        Map of function name -> ICompute for Lambda targets.
    queue_provider:
        Optional IQueue provider for SQS targets.
    sns_provider:
        Optional SNS provider (typed as object to avoid circular import).
    sfn_provider:
        Optional IStateMachine provider for Step Functions targets.
    """

    def __init__(
        self,
        compute_providers: dict[str, ICompute],
        queue_provider: IQueue | None,
        sns_provider: object | None,
        sfn_provider: IStateMachine | None,
    ) -> None:
        self._compute_providers = compute_providers
        self._queue_provider = queue_provider
        self._sns_provider = sns_provider
        self._sfn_provider = sfn_provider

    async def dispatch(self, target: RuleTarget, event: dict) -> None:
        """Dispatch *event* to *target*, routing by ARN service segment."""
        try:
            if ":sqs:" in target.arn:
                await self._dispatch_sqs(target, event)
            elif ":sns:" in target.arn:
                await self._dispatch_sns(target, event)
            elif ":states:" in target.arn:
                await self._dispatch_sfn(target, event)
            else:
                await self._dispatch_lambda(target, event)
        except Exception:
            logger.exception("Failed to dispatch event to target %s", target.arn)

    async def _dispatch_lambda(self, target: RuleTarget, event: dict) -> None:
        function_name = _extract_function_name(target.arn)
        compute = self._compute_providers.get(function_name)
        if compute is None:
            logger.error("No compute provider for target: %s", target.arn)
            return
        context = LambdaContext(
            function_name=function_name,
            memory_limit_in_mb=128,
            timeout_seconds=30,
            aws_request_id=str(uuid.uuid4()),
            invoked_function_arn=target.arn,
        )
        await compute.invoke(event, context)

    async def _dispatch_sqs(self, target: RuleTarget, event: dict) -> None:
        if self._queue_provider is None:
            logger.error("No queue provider configured for SQS target: %s", target.arn)
            return
        queue_name = target.arn.rsplit(":", 1)[-1]
        await self._queue_provider.send_message(
            queue_name=queue_name,
            message_body=json.dumps(event),
        )

    async def _dispatch_sns(self, target: RuleTarget, event: dict) -> None:
        if self._sns_provider is None:
            logger.error("No SNS provider configured for SNS target: %s", target.arn)
            return
        topic_name = target.arn.rsplit(":", 1)[-1]
        await self._sns_provider.publish(  # type: ignore[union-attr]
            topic_name=topic_name,
            message=json.dumps(event),
        )

    async def _dispatch_sfn(self, target: RuleTarget, event: dict) -> None:
        if self._sfn_provider is None:
            logger.error("No Step Functions provider configured for SFN target: %s", target.arn)
            return
        state_machine_name = target.arn.rsplit(":", 1)[-1]
        await self._sfn_provider.start_execution(
            state_machine_name=state_machine_name,
            input_data=event,
        )
