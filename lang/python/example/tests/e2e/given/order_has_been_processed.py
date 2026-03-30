"""Given: order_has_been_processed"""

from __future__ import annotations

from pytest_bdd import given, parsers

from src.order_processor import process_order

from ..constants import ScenarioContext


@given(parsers.parse('order "{order_id}" has been processed'))
def order_has_been_processed(ctx: ScenarioContext, order_id: str) -> None:
    process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
