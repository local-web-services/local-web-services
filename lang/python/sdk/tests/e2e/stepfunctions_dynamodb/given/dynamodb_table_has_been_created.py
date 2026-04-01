"""Given: a "dynamodb" "table" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given('a "dynamodb" "table" is created')
def dynamodb_table_has_been_created(lws_session):
    StepfunctionsDynamodbTestClient(lws_session).create_table()
