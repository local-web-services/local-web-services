"""Given: the "sns" "topic" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" was not "DELETED"')
def elasticache_sns_topic_has_been_deleted():
    """No-op: fresh state has no topics, simulates a previously deleted topic."""
