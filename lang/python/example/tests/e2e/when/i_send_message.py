"""When: i_send_message"""

from __future__ import annotations

from pytest_bdd import parsers, when

from ..constants import ScenarioContext


@when(parsers.parse('I send message body "{body}" to "{queue_name}"'))
def i_send_message(ctx: ScenarioContext, body: str, queue_name: str) -> None:
    ctx.sqs_helper.send(body)
