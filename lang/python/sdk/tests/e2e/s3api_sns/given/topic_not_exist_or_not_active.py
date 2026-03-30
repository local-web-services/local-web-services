"""Given: the topic does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the topic does not exist or is not "ACTIVE"')
def topic_not_exist_or_not_active():
    """No-op: fresh state has no topics, so the topic does not exist."""
