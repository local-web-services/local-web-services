"""Given: the transaction's table is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_PK, TEST_TABLE


@given('the transaction\'s table is not "ACTIVE"')
def transactions_table_is_not_active(lws_session, world):
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
    lws_session.client("dynamodb").create_table(
        TableName=TEST_TABLE,
        KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )
    world["result"] = None
    world["error"] = None
