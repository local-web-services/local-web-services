"""Given: the "sns" "subscription" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "subscription" did not exist')
def subscription_does_not_exist():
    """No-op: fresh provider state has no subscriptions for TEST_TOPIC."""
