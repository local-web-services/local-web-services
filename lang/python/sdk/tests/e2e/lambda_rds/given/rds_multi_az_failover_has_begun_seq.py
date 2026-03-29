"""Given: a Multi-"AZ" failover has begun on the "RDS" instance"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Multi-"AZ" failover has begun on the "RDS" instance')
def rds_multi_az_failover_has_begun_seq():
    pytest.skip("Cannot trigger RDS Multi-AZ failover in lws")
