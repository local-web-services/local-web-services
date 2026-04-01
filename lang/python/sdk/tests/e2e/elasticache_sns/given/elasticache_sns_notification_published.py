"""Given: a cluster event notification has been published to the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster event notification has been published to the topic")
def elasticache_sns_notification_published():
    pytest.skip("Cannot trigger internal ElastiCache cluster event notification in lws")
