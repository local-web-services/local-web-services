"""Given: no "sns" "subscription" was "CONFIRMED" for the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sns" "subscription" was "CONFIRMED" for the "sns" "topic"')
def sns_lambda_no_confirmed_subscription():
    """No-op: fresh state has no subscriptions."""
