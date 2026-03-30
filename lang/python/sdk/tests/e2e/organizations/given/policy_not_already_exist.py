"""Given: the policy does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the policy does not already exist")
def policy_not_already_exist():
    """No-op: fresh state has no policies."""
