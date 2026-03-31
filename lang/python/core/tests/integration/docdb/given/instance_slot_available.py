"""Given: the "documentdb" "instance" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "instance" slot is available')
def instance_slot_available():
    """No-op: lws does not enforce instance slot limits."""
