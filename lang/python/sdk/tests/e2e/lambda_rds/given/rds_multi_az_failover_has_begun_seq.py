"""Given: a Multi-"AZ" failover begins on the "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Multi-"AZ" failover begins on the "rds" "instance"')
def rds_multi_az_failover_has_begun_seq():
    pytest.skip("Cannot trigger RDS Multi-AZ failover in lws")
