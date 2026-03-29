"""When: a multi-"AZ" failover is triggered on a cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a multi-"AZ" failover is triggered on a cluster')
def multi_az_failover(client: TestClient, world: dict):
    pytest.skip("FailoverDBCluster is not yet implemented in lws.")
