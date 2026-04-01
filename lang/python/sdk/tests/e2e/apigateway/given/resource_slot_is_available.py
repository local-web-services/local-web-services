"""Given: a "api gateway" "resource" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('a "api gateway" "resource" slot is available')
def resource_slot_is_available():
    """No-op: fresh state has no REST APIs so a resource slot is available."""
