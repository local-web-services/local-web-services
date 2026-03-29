"""Given: the topic does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the topic does not exist")
def topic_does_not_exist():
    """No-op: fresh state has no topics."""
