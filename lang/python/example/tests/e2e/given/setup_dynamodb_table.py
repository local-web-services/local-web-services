"""Given: setup_dynamodb_table"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(parsers.parse('a DynamoDB table "{name}" with partition key "{partition_key}"'))
def setup_dynamodb_table(ctx: ScenarioContext, name: str, partition_key: str) -> None:
    ddb = ctx.session.client("dynamodb")
    ddb.create_table(
        TableName=name,
        KeySchema=[{"AttributeName": partition_key, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": partition_key, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )
    ctx.ddb_helper = ctx.session.dynamodb(name)
