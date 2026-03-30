"""Then: table_contains_n_items"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(parsers.parse('the table "{table_name}" will contain {count:d} item'))
@then(parsers.parse('the table "{table_name}" will contain {count:d} items'))
def table_contains_n_items(ctx: ScenarioContext, table_name: str, count: int) -> None:
    ctx.ddb_helper.assert_item_count(count)
