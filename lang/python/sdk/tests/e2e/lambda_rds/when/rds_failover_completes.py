"""When: the Multi-"AZ" failover completes and the new primary is promoted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Multi-"AZ" failover completes and the new primary is promoted')
def rds_failover_completes(world):
    pytest.skip("Cannot trigger RDS failover completion in lws")
