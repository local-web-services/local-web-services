"""Then: the item "EXISTS" and the request is "SUCCESS" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import _ITEM_KEY, TEST_TABLE


@then('the item "EXISTS" and the request is "SUCCESS"')
def item_exists_request_success(lws_session, world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
    resp = lws_session.client("dynamodb").get_item(
        TableName=TEST_TABLE, Key={_ITEM_KEY: {"S": "e2e-item-1"}}
    )
    actual_item = resp.get("Item")
    assert actual_item is not None, "Expected item to exist in DynamoDB but it was not found"
