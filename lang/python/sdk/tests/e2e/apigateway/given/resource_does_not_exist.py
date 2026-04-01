"""Given: the "api gateway" "resource" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "resource" did not exist')
def resource_does_not_exist():
    """No-op: fresh state after reset has no resources."""
