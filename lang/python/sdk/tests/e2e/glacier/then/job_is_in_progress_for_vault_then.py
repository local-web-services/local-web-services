"""Then: the job is InProgress for the given vault"""

from __future__ import annotations

from pytest_bdd import then


@then("the job is InProgress for the given vault")
def job_is_in_progress_for_vault_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected inventory retrieval job initiation to succeed but got: {actual_error}"
