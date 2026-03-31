"""Given: the Multi-"AZ" failover completes and the new primary is promoted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Multi-"AZ" failover completes and the new primary is promoted')
def rds_failover_has_completed_seq():
    pytest.skip("Cannot trigger RDS failover completion in lws")
