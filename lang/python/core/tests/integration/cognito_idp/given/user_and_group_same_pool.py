"""Given: the user and group belong to the same pool"""

from __future__ import annotations

from pytest_bdd import given


@given("the user and group belong to the same pool")
def user_and_group_same_pool():
    """No-op: both are created in the same pool by default."""
