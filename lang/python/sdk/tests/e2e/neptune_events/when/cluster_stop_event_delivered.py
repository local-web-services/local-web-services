"""When: the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "neptune" "cluster" stops and delivers the state change event to the EventBridge bus')
def cluster_stop_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop event routing in lws")
