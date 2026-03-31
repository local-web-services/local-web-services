"""When: an automatic failover promotes a new primary in a "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an automatic failover promotes a new primary in a "elasticache" "replication group"')
def automatic_failover_rg(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache failover in lws")
