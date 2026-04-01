"""Then: the "elasticsearch" "domain" will be "DELETED" and all its indices will be removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "domain" will be "DELETED" and all its indices will be removed')
def domain_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"
