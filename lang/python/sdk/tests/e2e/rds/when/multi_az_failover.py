"""When: a multi-"AZ" failover is triggered on a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a multi-"AZ" failover is triggered on a "rds" "instance"')
def multi_az_failover(lws_session, world):
    pytest.skip("Cannot trigger internal RDS multi-AZ failover in lws")
