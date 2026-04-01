"""Given: the "dynamodb" "table" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given('the "dynamodb" "table" already existed')
def table_already_exists(lws_session):
    StepfunctionsDynamodbTestClient(lws_session).create_table()
