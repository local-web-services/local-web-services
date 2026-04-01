"""Given: the "glacier" "job" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "job" slot is available')
def job_slot_available():
    """No-op: always room for jobs."""
