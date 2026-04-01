"""Then: the active execution count increases"""

from __future__ import annotations

from pytest_bdd import then


@then("the active execution count increases")
def active_execution_count_increases(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected invocation to succeed but got: {actual_error}"
