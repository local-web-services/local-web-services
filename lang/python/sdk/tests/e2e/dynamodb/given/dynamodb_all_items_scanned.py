"""Given: all items in the table have been scanned"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("all items in the table have been scanned")
def dynamodb_all_items_scanned(lws_session):
    DynamodbTestClient(lws_session).create_table()
