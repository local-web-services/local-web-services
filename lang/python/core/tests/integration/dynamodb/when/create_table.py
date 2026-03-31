"""When: a "dynamodb" "table" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_PK, TEST_TABLE, _store


@when('a "dynamodb" "table" is created')
def create_table(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "CreateTable",
        {
            "TableName": TEST_TABLE,
            "KeySchema": [{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            "AttributeDefinitions": [{"AttributeName": TEST_PK, "AttributeType": "S"}],
            "BillingMode": "PAY_PER_REQUEST",
        },
    )
    _store(world, r)
