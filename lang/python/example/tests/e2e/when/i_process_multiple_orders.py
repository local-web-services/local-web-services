"""When: i_process_multiple_orders"""

from __future__ import annotations

from pytest_bdd import parsers, when

from src.order_processor import process_order

from ..constants import ScenarioContext


@when(parsers.parse('I process orders "{id1}", "{id2}", "{id3}"'))
def i_process_multiple_orders(ctx: ScenarioContext, id1: str, id2: str, id3: str) -> None:
    ctx.processed_outputs = []
    ctx.processed_ids = [id1, id2, id3]
    for order_id in ctx.processed_ids:
        output = process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
        ctx.processed_outputs.append(output)
