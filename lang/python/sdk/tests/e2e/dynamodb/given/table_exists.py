"""Given: the table exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the table exists")
def table_exists(lws_session):
    DynamodbTestClient(lws_session).create_table()
