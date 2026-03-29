"""Given: the user pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the user pool is "ACTIVE"')
def pool_is_active():
    """No-op: the pool is always ACTIVE immediately after initialisation."""
