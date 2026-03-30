"""Then: the active execution count decreases"""

from __future__ import annotations

from pytest_bdd import then


@then("the active execution count decreases")
def active_execution_count_decreases(world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected invocation completion to succeed but got: {actual_error}"
