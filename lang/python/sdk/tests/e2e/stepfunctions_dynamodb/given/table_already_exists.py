"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given("the table already exists")
def table_already_exists(lws_session):
    StepfunctionsDynamodbTestClient(lws_session).create_table()
