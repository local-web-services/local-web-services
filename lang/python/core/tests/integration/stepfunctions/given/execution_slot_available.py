"""Given: the execution slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""
