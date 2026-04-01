"""Given: the "sns" "subscription"'s "sns" "topic" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "subscription"\'s "sns" "topic" was "ACTIVE"')
@given('the subscription\'s topic is "ACTIVE"')
def subscriptions_topic_is_active():
    """No-op: topic is ACTIVE by default."""
