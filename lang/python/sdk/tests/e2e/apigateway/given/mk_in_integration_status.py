"""Given: mk in integration_status"""

from __future__ import annotations

from pytest_bdd import given


@given("mk in integration_status")
def mk_in_integration_status():
    """No-op: integration state is established during API setup in the test."""
