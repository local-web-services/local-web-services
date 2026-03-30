"""Given: the table exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient


@given("the table exists")
def table_exists(lws_session):
    LambdaDynamodbTestClient(lws_session).create_table()
