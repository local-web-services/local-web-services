"""Given: the "rds" "DB instance" failover completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "DB instance" failover completes')
def db_instance_failover_completed_given():
    pytest.skip("Cannot pre-set a completed DB instance failover state for sequence setup")
