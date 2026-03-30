"""Given: the item is present"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the item is present")
def item_is_present(lws_session):
    DynamodbTestClient(lws_session).put_item()
