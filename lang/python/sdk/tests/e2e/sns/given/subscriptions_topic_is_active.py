"""Given: the subscription's sns topic was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "subscription"\'s "sns" "topic" was "ACTIVE"')
def subscriptions_topic_is_active():
    """No-op: topic is ACTIVE by default."""
