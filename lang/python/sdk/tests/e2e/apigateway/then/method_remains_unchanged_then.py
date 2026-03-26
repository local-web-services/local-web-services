"""Then: the method remains unchanged"""

from __future__ import annotations

from pytest_bdd import then


@then("the method remains unchanged")
def method_remains_unchanged_then(lws_session, world):
    assert world["error"] is None, f"Expected update_method to succeed but got: {world['error']}"
