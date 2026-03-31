"""Given: the "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "topic" is deleted')
def glacier_sns_seq_topic_deleted():
    """No-op: fresh state has no topics, simulates a previously deleted topic."""
