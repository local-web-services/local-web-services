"""Given: no confirmed subscription exists for the topic"""

from __future__ import annotations

from pytest_bdd import given


@given("no confirmed subscription exists for the topic")
def sns_lambda_no_confirmed_subscription():
    """No-op: fresh state has no subscriptions."""
