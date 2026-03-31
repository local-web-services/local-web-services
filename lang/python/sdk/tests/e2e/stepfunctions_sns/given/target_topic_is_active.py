"""Given: the target topic was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target topic was "ACTIVE"')
def target_topic_is_active():
    """No-op: topics are ACTIVE immediately after creation."""
