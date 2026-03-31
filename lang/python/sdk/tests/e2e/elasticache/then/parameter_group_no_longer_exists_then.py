"""Then: the "elasticache" parameter group no longer will exist"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticache" parameter group no longer will exist')
def parameter_group_no_longer_exists_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected parameter group delete to succeed but got: {actual_error}"
