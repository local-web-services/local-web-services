"""Then: the message is "AVAILABLE" on the topic"""

from __future__ import annotations

from pytest_bdd import then


@then('the message is "AVAILABLE" on the topic')
def message_available_on_topic(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
