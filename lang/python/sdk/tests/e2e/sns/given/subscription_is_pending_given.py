"""Given: the subscription is "PENDING_CONFIRMATION" """

from __future__ import annotations

from pytest_bdd import given


@given('the subscription is "PENDING_CONFIRMATION"')
def subscription_is_pending_given():
    """No-op: email subscriptions are PENDING_CONFIRMATION by default."""
