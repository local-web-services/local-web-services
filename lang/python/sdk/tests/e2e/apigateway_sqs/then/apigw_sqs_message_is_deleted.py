"""Then: the "sqs" "message" will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then('the "sqs" "message" will be deleted')
def apigw_sqs_message_is_deleted(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected consumer to process the message but result is None"
    expected_deleted = True
    actual_deleted = actual_result.get("deleted", False)
    assert (
        actual_deleted == expected_deleted
    ), f"Expected message to be deleted but got: {actual_result}"
