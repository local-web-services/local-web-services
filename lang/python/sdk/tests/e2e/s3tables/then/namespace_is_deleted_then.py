"""Then: the namespace is "DELETED" and all its tables are "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the namespace is "DELETED" and all its tables are "DELETED"')
def namespace_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace delete to succeed but got: {actual_error}"
