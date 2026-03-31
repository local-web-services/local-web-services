"""Given: the "api gateway" "API" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "API" did not exist')
def api_does_not_exist():
    """No-op: fresh state after reset has no REST APIs."""
