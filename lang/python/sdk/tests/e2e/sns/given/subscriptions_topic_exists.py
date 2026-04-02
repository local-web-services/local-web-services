"""Given: the "sns" "subscription"'s "sns" "topic" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "subscription"\'s "sns" "topic" existed')
def subscriptions_topic_exists():
    """No-op: topic was created in the topic_exists step."""
