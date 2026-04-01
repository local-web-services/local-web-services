"""Given: the "cognito" "user pool" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user pool" existed')
def pool_exists():
    """No-op: the provider fixture initialises the pool at startup."""
