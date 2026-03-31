"""Given: the "api gateway" "deployment" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "deployment" slot is available')
def deployment_slot_available():
    """No-op: fresh state has an available deployment slot."""
