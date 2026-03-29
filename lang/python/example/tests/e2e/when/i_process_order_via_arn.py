"""When: i_process_order_via_arn"""

from __future__ import annotations

from pytest_bdd import parsers, when

from src.order_processor import process_order

from ..constants import ScenarioContext


@when(parsers.parse('I process order "{order_id}" via ARN "{arn}"'))
def i_process_order_via_arn(ctx: ScenarioContext, order_id: str, arn: str) -> None:
    ctx.last_error = None
    ctx.last_output = None
    try:
        ctx.last_output = process_order(order_id, arn, ctx.sfn_client)
    except Exception as e:
        ctx.last_error = e
