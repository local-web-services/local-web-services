"""Then: the "sqs" "message" will be "AVAILABLE" in the target "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import then


@then('the "sqs" "message" will be "AVAILABLE" in the target "sqs" "queue"')
def message_available_in_target_queue(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
