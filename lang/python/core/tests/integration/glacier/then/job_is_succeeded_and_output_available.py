"""Then: the "glacier" "JOB" will be "Succeeded" and its output will be available"""

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "JOB" will be "Succeeded" and its output will be available')
def job_is_succeeded_and_output_available(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job to succeed but got: {actual_error}"
