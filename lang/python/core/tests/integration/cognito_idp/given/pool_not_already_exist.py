"""Given: the user pool does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the user pool does not already exist")
def pool_not_already_exist():
    """No-op: the provider fixture always starts with its configured pool only."""
