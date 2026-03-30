"""Given: the cluster modification event failed to reach the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster modification event failed to reach the topic")
def elasticache_sns_modification_event_failed():
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")
