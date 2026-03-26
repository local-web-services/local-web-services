"""Then: the message is "AVAILABLE" in the target queue"""

from __future__ import annotations

from pytest_bdd import then


@then('the message is "AVAILABLE" in the target queue')
def message_available_in_target_queue(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
