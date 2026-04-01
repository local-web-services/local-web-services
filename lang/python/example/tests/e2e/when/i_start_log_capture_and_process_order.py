"""When: i_start_log_capture_and_process_order"""

from __future__ import annotations

from pytest_bdd import parsers, when

from src.order_processor import process_order

from ..constants import ScenarioContext


@when(parsers.parse('I start log capture and process order "{order_id}"'))
def i_start_log_capture_and_process_order(ctx: ScenarioContext, order_id: str) -> None:
    cm = ctx.session.capture_logs()
    ctx._log_capture_cm = cm
    ctx.log_capture = cm.__enter__()
    ctx.last_error = None
    ctx.last_output = None
    try:
        ctx.last_output = process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
    except Exception as e:
        ctx.last_error = e
