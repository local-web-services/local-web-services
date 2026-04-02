"""Given: a Multi-"AZ" failover begins on the "rds" "DB instance" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a Multi-"AZ" failover begins on the "rds" "DB instance"')
def multi_az_failover_begun_given():
    pytest.skip("Cannot pre-set a Multi-AZ failover state for sequence setup")
