"""When: "dynamodb" "item"s are queried from a "dynamodb" "GSI" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import GSI_INDEX, GSI_PK, GSI_PK_VALUE, GSI_TABLE, _store


@when('"dynamodb" "item"s are queried from a "dynamodb" "GSI"')
def query_gsi(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "Query",
        {
            "TableName": GSI_TABLE,
            "IndexName": GSI_INDEX,
            "KeyConditionExpression": "#gsi_pk = :gsi_val",
            "ExpressionAttributeNames": {"#gsi_pk": GSI_PK},
            "ExpressionAttributeValues": {":gsi_val": {"S": GSI_PK_VALUE}},
        },
    )
    _store(world, r)
