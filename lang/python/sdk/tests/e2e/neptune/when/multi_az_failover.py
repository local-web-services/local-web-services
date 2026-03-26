"""When: a multi-"AZ" failover is triggered on a cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a multi-"AZ" failover is triggered on a cluster')
def multi_az_failover(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune multi-AZ failover in lws")
