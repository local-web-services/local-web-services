"""Given: setup_sqs_queue"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(parsers.parse('an SQS queue named "{queue_name}"'))
def setup_sqs_queue(ctx: ScenarioContext, queue_name: str) -> None:
    sqs = ctx.session.client("sqs")
    sqs.create_queue(QueueName=queue_name)
    ctx.sqs_helper = ctx.session.sqs(queue_name)
