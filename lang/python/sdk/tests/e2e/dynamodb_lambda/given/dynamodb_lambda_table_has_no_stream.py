"""Given: the table does not have a stream enabled"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not have a stream enabled")
def dynamodb_lambda_table_has_no_stream(world):
    world["_skip"] = "lws does not fail put_item when the table has no stream enabled"
