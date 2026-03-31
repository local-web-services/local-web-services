"""Given: the "sns" "topic" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" was "ACTIVE"')
@given('the "sns" "topic" will be "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""
