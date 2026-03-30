"""Given: the subscription's topic exists"""

from __future__ import annotations

from pytest_bdd import given


@given("the subscription's topic exists")
def subscriptions_topic_exists():
    """No-op: topic was created in the topic_exists step."""
