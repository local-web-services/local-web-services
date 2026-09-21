"""Then: the item will be updated in the "dynamodb" "table" and the "step functions" "execution" will be "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_STATUS_ATTR, TEST_TABLE, TEST_UPDATED_STATUS


@then(
    'the item will be updated in the "dynamodb" "table" and the "step functions" "execution" will be "SUCCEEDED"'
)
def item_is_updated_and_execution_succeeded(lws_session, world):
    expected_error = None
    expected_status = TEST_UPDATED_STATUS
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    actual_resp = lws_session.client("dynamodb").get_item(
        TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
    )
    actual_item = actual_resp.get("Item", {})
    assert (
        actual_item
    ), f"Expected item with key '{TEST_ITEM_KEY}' to exist in table '{TEST_TABLE}' but got empty item"
    actual_status = actual_item.get(TEST_STATUS_ATTR, {}).get("S")
    assert (
        actual_status == expected_status
    ), f"Expected '{TEST_STATUS_ATTR}' to be {expected_status!r} but got {actual_status!r}"
