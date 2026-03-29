"""When: i_put_item"""

from __future__ import annotations

from pytest_bdd import parsers, when

from ..constants import ScenarioContext


@when(
    parsers.parse('I put item with orderId "{order_id}" and status "{status}" into "{table_name}"')
)  # noqa: E501
def i_put_item(ctx: ScenarioContext, order_id: str, status: str, table_name: str) -> None:
    ctx.ddb_helper.put({"orderId": {"S": order_id}, "status": {"S": status}})
