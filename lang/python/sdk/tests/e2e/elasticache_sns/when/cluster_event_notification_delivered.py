"""
When: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS"
topic
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    "a cluster modification event occurs and ElastiCache publishes a notification "
    'to the "SNS" topic'
)
def cluster_event_notification_delivered(lws_session, world):
    pytest.skip(
        "Cannot trigger internal ElastiCache cluster modification event notification in lws"
    )
