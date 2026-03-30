"""Given: the job is not InProgress"""

from __future__ import annotations

from pytest_bdd import given


@given("the job is not InProgress")
def job_is_not_in_progress_given():
    """No-op: fresh state has no in-progress jobs."""
