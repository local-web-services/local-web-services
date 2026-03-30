"""Given: the "API" does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "API" does not already exist')
def api_does_not_already_exist():
    """No-op: fresh state has no REST APIs."""
