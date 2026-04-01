"""Given: the "sns" "topic" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" was "ACTIVE"')
def glacier_sns_topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""
