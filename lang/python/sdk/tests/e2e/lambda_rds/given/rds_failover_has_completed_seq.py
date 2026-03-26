"""Given: the Multi-"AZ" failover has completed and the new primary has been promoted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the Multi-"AZ" failover has completed and the new primary has been promoted')
def rds_failover_has_completed_seq():
    pytest.skip("Cannot trigger RDS failover completion in lws")
