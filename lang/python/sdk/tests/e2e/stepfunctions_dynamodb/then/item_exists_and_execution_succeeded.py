"""Then: the item "EXISTS" in the table and the execution is "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then('the item "EXISTS" in the table and the execution is "SUCCEEDED"')
def item_exists_and_execution_succeeded(lws_session, world):
    expected_error = None
    expected_item_key = TEST_ITEM_KEY
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    actual_resp = lws_session.client("dynamodb").get_item(
        TableName=TEST_TABLE, Key={TEST_PK: {"S": expected_item_key}}
    )
    actual_item = actual_resp.get("Item", {})
    assert (
        actual_item
    ), f"Expected item with key '{expected_item_key}' to exist in table '{TEST_TABLE}' but got empty item"  # noqa: E501
