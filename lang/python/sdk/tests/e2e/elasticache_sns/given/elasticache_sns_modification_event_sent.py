"""Given: the cluster modification event has been sent to the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the cluster modification event has been sent to the topic")
def elasticache_sns_modification_event_sent():
    pytest.skip("Cannot trigger internal ElastiCache modification event in lws")
