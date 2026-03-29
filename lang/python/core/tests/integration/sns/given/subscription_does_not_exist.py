"""Given: the subscription does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the subscription does not exist")
def subscription_does_not_exist():
    """No-op: fresh provider state has no subscriptions for TEST_TOPIC."""
