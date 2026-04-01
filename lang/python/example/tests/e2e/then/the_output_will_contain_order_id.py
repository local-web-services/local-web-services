"""Then: the_output_will_contain_order_id"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('the output will contain order ID "{expected_order_id}"'))
def the_output_will_contain_order_id(ctx: ScenarioContext, expected_order_id: str) -> None:
    assert ctx.last_error is None, f"expected no error but got: {ctx.last_error}"
    assert ctx.last_output is not None, "expected non-nil output"
    actual_order_id = ctx.last_output.get("orderId")
    assert (
        actual_order_id == expected_order_id
    ), f"output orderId = {actual_order_id!r}, want {expected_order_id!r}"
