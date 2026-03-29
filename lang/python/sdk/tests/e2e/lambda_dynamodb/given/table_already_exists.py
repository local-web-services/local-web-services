"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient


@given("the table already exists")
def table_already_exists(lws_session):
    LambdaDynamodbTestClient(lws_session).create_table()
