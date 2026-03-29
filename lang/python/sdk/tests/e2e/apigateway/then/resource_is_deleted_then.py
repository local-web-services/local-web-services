"""Then: the resource is "DELETED" along with all its methods and integrations"""

from __future__ import annotations

from pytest_bdd import then


@then('the resource is "DELETED" along with all its methods and integrations')
def resource_is_deleted_then(lws_session, world):
    assert world["error"] is None, f"Expected delete_resource to succeed but got: {world['error']}"
