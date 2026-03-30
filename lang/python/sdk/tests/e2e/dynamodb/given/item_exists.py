"""Given: the item exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the item exists")
def item_exists(lws_session):
    DynamodbTestClient(lws_session).put_item()
