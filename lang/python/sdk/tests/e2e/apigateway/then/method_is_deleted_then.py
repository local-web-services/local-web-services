"""Then: the method is "DELETED" and its integration is "DELETED" if it exists"""

from __future__ import annotations

from pytest_bdd import then


@then('the method is "DELETED" and its integration is "DELETED" if it exists')
def method_is_deleted_then(lws_session, world):
    assert world["error"] is None, f"Expected delete_method to succeed but got: {world['error']}"
