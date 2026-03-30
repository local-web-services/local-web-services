"""Given: the "SNS" topic has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "SNS" topic has been deleted')
def elasticache_sns_topic_has_been_deleted():
    """No-op: fresh state has no topics, simulates a previously deleted topic."""
