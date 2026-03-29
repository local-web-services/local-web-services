"""Then: the subnet group no longer exists"""

from __future__ import annotations

from pytest_bdd import then


@then("the subnet group no longer exists")
def subnet_group_no_longer_exists_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected subnet group delete to succeed but got: {actual_error}"
