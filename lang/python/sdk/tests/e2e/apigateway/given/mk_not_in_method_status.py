"""Given: mk not in method_status"""

from __future__ import annotations

from pytest_bdd import given


@given("mk not in method_status")
def mk_not_in_method_status():
    """No-op: fresh state has no methods."""
