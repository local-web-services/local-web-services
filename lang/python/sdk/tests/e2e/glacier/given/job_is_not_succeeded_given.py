"""Given: the job is not Succeeded"""

from __future__ import annotations

from pytest_bdd import given


@given("the job is not Succeeded")
def job_is_not_succeeded_given():
    """No-op: fresh state has no succeeded jobs."""
