"""Then: the query results contain the item"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the query results contain the item")
def query_results_contain_item_then(lws_session):
    client = lws_session.client("dynamodb")
    resp = client.query(
        TableName=TEST_TABLE,
        KeyConditionExpression="#pk = :pk",
        ExpressionAttributeNames={"#pk": TEST_PK},
        ExpressionAttributeValues={":pk": {"S": TEST_ITEM_KEY}},
    )
    assert resp.get("Count", 0) >= 1, "Expected at least one item in query results"
