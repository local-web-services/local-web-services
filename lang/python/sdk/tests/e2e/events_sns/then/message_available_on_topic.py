"""Then: the "sns" "message" will be "AVAILABLE" on the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import then


@then('the "sns" "message" will be "AVAILABLE" on the "sns" "topic"')
def message_available_on_topic(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
