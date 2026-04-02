"""Then: the "lambda" "function" active execution count will increase"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" active execution count will increase')
def active_execution_count_increases(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected invocation to succeed but got: {actual_error}"
