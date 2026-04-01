"""Then: the "glacier" "JOB" will be "InProgress" for the given "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "JOB" will be "InProgress" for the given "glacier" "vault"')
def job_is_in_progress_for_vault_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected inventory retrieval job initiation to succeed but got: {actual_error}"
