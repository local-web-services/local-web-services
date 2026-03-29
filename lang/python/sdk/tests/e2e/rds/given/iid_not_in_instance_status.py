"""Given: iid not in instance_status"""

from __future__ import annotations

from pytest_bdd import given


@given("iid not in instance_status")
def iid_not_in_instance_status():
    """No-op: fresh state has no instances."""
