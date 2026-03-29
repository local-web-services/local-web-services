"""Given: the job slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the job slot is available")
def job_slot_available():
    """No-op: job slots are always available in isolated tests."""
