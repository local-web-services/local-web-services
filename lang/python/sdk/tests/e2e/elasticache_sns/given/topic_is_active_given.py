"""Given: the topic is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""
