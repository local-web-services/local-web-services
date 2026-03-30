"""When: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus')
def execution_succeeds_event_delivered(world):
    pytest.skip("Cannot trigger internal execution completion with event delivery in lws")
