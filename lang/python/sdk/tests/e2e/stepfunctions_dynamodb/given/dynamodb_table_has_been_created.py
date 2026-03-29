"""Given: a DynamoDB table has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given("a DynamoDB table has been created")
def dynamodb_table_has_been_created(lws_session):
    StepfunctionsDynamodbTestClient(lws_session).create_table()
