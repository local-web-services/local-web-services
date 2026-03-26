"""Given: the connection slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the connection slot is available")
def connection_slot_available():
    """No-op: always room for connections."""
