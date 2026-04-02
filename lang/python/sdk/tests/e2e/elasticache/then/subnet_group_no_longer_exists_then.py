"""Then: the "elasticache" "subnet group" will no longer exist"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticache" "subnet group" will no longer exist')
def subnet_group_no_longer_exists_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected subnet group delete to succeed but got: {actual_error}"
