"""Then: the "lambda" "function" active execution count will decrease"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" active execution count will decrease')
def active_execution_count_decreases(world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected invocation completion to succeed but got: {actual_error}"
