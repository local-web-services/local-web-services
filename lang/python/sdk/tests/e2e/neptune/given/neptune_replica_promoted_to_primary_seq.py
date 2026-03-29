"""Given: a replica instance has been promoted to primary during failover"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replica instance has been promoted to primary during failover")
def neptune_replica_promoted_to_primary_seq():
    pytest.skip("Cannot trigger internal Neptune replica promotion in lws")
