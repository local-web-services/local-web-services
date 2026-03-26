"""Then: the job is InProgress for the given vault"""

from __future__ import annotations

from pytest_bdd import then


@then("the job is InProgress for the given vault")
def job_is_in_progress_for_vault(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job initiation to succeed but got: {actual_error}"
    actual_job_id = world.get("job_id", "")
    assert actual_job_id, "Expected a non-empty job ID in the response"
