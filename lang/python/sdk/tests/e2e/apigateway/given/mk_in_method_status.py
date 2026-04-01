"""Given: mk in method_status"""

from __future__ import annotations

from pytest_bdd import given


@given("mk in method_status")
def mk_in_method_status():
    """No-op: method state is established during API setup in the test."""
