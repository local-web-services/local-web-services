"""Then: the "api gateway" "method" will be deleted and its integration will be deleted if it will exist"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "api gateway" "method" will be deleted and its integration will be deleted if it will exist'
)
def method_is_deleted_then(lws_session, world):
    assert world["error"] is None, f"Expected delete_method to succeed but got: {world['error']}"
