"""Given: the "glacier" "job" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "job" did not exist')
def job_does_not_exist():
    """No-op: fresh state has no jobs."""
