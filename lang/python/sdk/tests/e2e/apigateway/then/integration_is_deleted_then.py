"""Then: the integration is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the integration is "DELETED"')
def integration_is_deleted_then(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected delete_integration to succeed but got: {world['error']}"
