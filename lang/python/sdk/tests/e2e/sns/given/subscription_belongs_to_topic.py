"""Given: the "sns" "subscription" belongs to this "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "subscription" belongs to this "sns" "topic"')
def subscription_belongs_to_topic():
    """No-op: subscription was created for this topic."""
