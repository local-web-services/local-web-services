"""Given: the topic does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""
