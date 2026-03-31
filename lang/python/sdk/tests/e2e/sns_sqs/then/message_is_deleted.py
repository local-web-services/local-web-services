"""Then: the message will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the message will be deleted")
def message_is_deleted(world):
    assert world["error"] is None, f"Expected consume to succeed but got: {world['error']}"
