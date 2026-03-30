"""
Given: a cluster event has occurred but the "SNS" notification has failed because the topic has
been deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted'  # noqa: E501
)
def elasticache_sns_cluster_event_notification_failed():
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")
