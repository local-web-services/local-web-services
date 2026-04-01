"""When: a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "documentdb" "cluster" modification begins but event delivery fails because the bus is deleted'
)
def cluster_modify_event_fails(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB event delivery failure in lws")
