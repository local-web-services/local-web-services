"""Given: the "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient


@given('the "dynamodb" "table" existed')
def table_exists(lws_session):
    LambdaDynamodbTestClient(lws_session).create_table()
