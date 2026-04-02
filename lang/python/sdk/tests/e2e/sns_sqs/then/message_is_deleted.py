"""Then: the "sqs" "message" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "sqs" "message" will be "DELETED"')
def message_is_deleted(world):
    assert world["error"] is None, f"Expected consume to succeed but got: {world['error']}"
