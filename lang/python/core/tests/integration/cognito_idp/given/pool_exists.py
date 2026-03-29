"""Given: the user pool exists"""

from __future__ import annotations

from pytest_bdd import given


@given("the user pool exists")
def pool_exists():
    """No-op: the provider fixture initialises the pool at startup."""
