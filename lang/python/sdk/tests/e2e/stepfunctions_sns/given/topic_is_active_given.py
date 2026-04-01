"""Given: the target topic was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target topic was "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""
