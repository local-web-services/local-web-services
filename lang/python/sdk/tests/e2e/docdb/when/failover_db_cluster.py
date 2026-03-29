"""When: a failover is triggered and a replica is promoted to primary"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a failover is triggered and a replica is promoted to primary")
def failover_db_cluster(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB failover in lws")
