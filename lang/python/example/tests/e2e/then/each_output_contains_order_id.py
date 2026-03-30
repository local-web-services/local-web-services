"""Then: each output will contain the corresponding order ID"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import ScenarioContext


@then("each output will contain the corresponding order ID")
def each_output_contains_order_id(ctx: ScenarioContext) -> None:
    assert len(ctx.processed_outputs) == len(
        ctx.processed_ids
    ), f"expected {len(ctx.processed_ids)} outputs, got {len(ctx.processed_outputs)}"
    for i, (output, expected_id) in enumerate(zip(ctx.processed_outputs, ctx.processed_ids)):
        actual_id = output.get("orderId")
        assert (
            actual_id == expected_id
        ), f"output[{i}] orderId = {actual_id!r}, want {expected_id!r}"
