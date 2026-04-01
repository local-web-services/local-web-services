"""
When: a cluster event occurs but the "SNS" notification fails because the topic has been deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted'
)
def cluster_event_notification_fails(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")
