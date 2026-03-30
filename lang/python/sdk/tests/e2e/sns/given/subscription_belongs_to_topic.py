"""Given: the subscription belongs to this topic"""

from __future__ import annotations

from pytest_bdd import given


@given("the subscription belongs to this topic")
def subscription_belongs_to_topic():
    """No-op: subscription was created for this topic."""
