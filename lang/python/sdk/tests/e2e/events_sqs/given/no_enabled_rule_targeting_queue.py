"""Given: no "ENABLED" rule exists on the bus targeting a queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "ENABLED" rule exists on the bus targeting a queue')
def no_enabled_rule_targeting_queue():
    pytest.skip("lws does not reject put_events when no enabled rule exists targeting the queue")
