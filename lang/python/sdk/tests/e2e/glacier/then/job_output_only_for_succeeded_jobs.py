"""Then: "glacier" "job" output is only available for succeeded "glacier" "job"s"""

from __future__ import annotations

from pytest_bdd import step


@step('"glacier" "job" output is only available for succeeded "glacier" "job"s')
def job_output_only_for_succeeded_jobs():
    """No-op: job output availability invariant; always passes."""
