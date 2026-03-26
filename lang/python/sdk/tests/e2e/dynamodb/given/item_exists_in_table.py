"""Given: the item exists in the table"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the item exists in the table")
def item_exists_in_table(lws_session):
    DynamodbTestClient(lws_session).put_item()
