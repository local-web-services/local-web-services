"""Then: the "glacier" "job" output will be marked as retrieved"""

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "job" output will be marked as retrieved')
def job_output_is_marked_as_retrieved(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected get-job-output to succeed but got: {actual_error}"
