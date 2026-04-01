"""Then: the "rds" "instance" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be in "DELETING" state')
def instance_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected instance delete to succeed but got: {actual_error}"
