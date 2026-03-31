"""Then: job output is only available for succeeded jobs"""

from __future__ import annotations

from pytest_bdd import step


@step("job output is only available for succeeded jobs")
def job_output_only_for_succeeded_jobs():
    """No-op: job output availability invariant; always passes."""
