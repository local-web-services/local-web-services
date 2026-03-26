"""Then: the topic is "DELETED" and Glacier notifications will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the topic is "DELETED" and Glacier notifications will fail')
def glacier_sns_topic_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_topic to succeed but got: {actual_error}"
