"""Then: the execution will be "TIMED_OUT" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution will be "TIMED_OUT"')
def execution_is_timed_out_then(world):
    assert world["error"] is None, f"Expected timeout event to succeed but got: {world['error']}"
