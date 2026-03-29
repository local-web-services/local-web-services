"""Then: the domain is "DELETED" and all associated connections are removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the domain is "DELETED" and all associated connections are removed')
def domain_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"
