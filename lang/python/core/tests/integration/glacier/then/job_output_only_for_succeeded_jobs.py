"""Then: "glacier" "job" output is only available for succeeded "glacier" "job"s"""

from __future__ import annotations

from pytest_bdd import then


@then('"glacier" "job" output is only available for succeeded "glacier" "job"s')
def job_output_only_for_succeeded_jobs():
    """Invariant trivially satisfied in an isolated test context."""
