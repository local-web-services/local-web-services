"""Then: the "glacier" "job" will be "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "job" will be "IN_PROGRESS"')
def glacier_job_is_in_progress_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected initiate_job to succeed but got: {actual_error}"
    assert world["result"] is not None, "Expected a result from initiate_job"
