"""When: the Neptune cluster stops but event delivery fails because the bus is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Neptune cluster stops but event delivery fails because the bus is deleted")
def cluster_stop_event_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune event delivery failure in lws")
