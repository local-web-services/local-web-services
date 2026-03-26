"""Given: an archive slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("an archive slot is available")
def archive_slot_available():
    """No-op: always room for archives."""
