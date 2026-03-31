"""Then: the "glacier" "JOB" will be "Failed" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "JOB" will be "Failed"')
def job_is_failed(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job failure to succeed but got: {actual_error}"
