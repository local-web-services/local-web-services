"""Given: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"'
)
def elasticache_sns_modification_event_sent():
    pytest.skip("Cannot trigger internal ElastiCache modification event in lws")
