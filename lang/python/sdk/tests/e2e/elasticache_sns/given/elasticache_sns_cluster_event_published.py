"""
Given: a cluster event has occurred and ElastiCache has published a notification to the "SNS"
topic
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic'
)
def elasticache_sns_cluster_event_published():
    pytest.skip("Cannot trigger internal ElastiCache cluster event notification in lws")
