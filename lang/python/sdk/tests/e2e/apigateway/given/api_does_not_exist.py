"""Given: the "API" does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "API" does not exist')
def api_does_not_exist():
    """No-op: fresh state after reset has no REST APIs."""
