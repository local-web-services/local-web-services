"""When: a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "documentdb" "cluster" modification begins and DocumentDB delivers the event to the EventBridge bus'
)
def cluster_modify_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB cluster modification event routing in lws")
