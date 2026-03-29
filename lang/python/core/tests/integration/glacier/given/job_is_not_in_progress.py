"""Given: the job is not InProgress"""

from __future__ import annotations

from pytest_bdd import given


@given("the job is not InProgress")
def job_is_not_in_progress():
    """No-op: jobs are Succeeded immediately in the lws implementation."""
