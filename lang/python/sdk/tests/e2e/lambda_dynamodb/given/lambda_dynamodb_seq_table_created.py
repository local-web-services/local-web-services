"""Given: a "dynamodb" "table" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDynamodbTestClient


@given('a "dynamodb" "table" is created')
def lambda_dynamodb_seq_table_created(lws_session):
    LambdaDynamodbTestClient(lws_session).create_table()
