"""Given: no job was "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given


@given('no job was "IN_PROGRESS"')
def glacier_no_job_is_in_progress():
    """No-op: fresh state has no in-progress jobs."""
