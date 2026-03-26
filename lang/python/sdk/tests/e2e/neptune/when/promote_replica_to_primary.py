"""When: a replica instance is promoted to primary during failover"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replica instance is promoted to primary during failover")
def promote_replica_to_primary(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune replica promotion in lws")
