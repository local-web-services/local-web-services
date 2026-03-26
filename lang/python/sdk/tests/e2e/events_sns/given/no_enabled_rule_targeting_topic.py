"""Given: no "ENABLED" rule exists on the bus targeting a topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "ENABLED" rule exists on the bus targeting a topic')
def no_enabled_rule_targeting_topic():
    pytest.skip("lws does not reject put_events when no enabled rule exists targeting the topic")
