"""Given: a record slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("a record slot is available")
def record_slot_available():
    """No-op: always room for records."""
