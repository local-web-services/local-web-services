"""Then: table_contains_item_with_order_id"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('the table "{table_name}" will contain an item with orderId "{order_id}"'))
def table_contains_item_with_order_id(ctx: ScenarioContext, table_name: str, order_id: str) -> None:
    ctx.ddb_helper.assert_item_exists({"orderId": {"S": order_id}})
