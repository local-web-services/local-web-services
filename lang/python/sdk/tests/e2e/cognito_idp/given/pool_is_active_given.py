"""Given: the user pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the user pool is "ACTIVE"')
def pool_is_active_given():
    """No-op: user pools are ACTIVE immediately after creation."""
