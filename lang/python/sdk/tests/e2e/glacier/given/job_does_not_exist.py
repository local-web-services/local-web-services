"""Given: the job does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the job does not exist")
def job_does_not_exist():
    """No-op: fresh state has no jobs."""
