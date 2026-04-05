"""Given: the "dynamodb" "GSI" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('the "dynamodb" "GSI" existed')
def gsi_existed(lws_session):
    c = DynamodbTestClient(lws_session)
    c.create_gsi_table()
    c.put_gsi_item()
