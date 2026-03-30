"""Given: tid not in topic_status"""

from __future__ import annotations

from pytest_bdd import given


@given("tid not in topic_status")
def glacier_sns_tid_not_in_topic_status():
    """No-op: fresh state has no topics."""
