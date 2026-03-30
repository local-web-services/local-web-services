"""Given: a multi-"AZ" failover has been triggered on an instance"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a multi-"AZ" failover has been triggered on an instance')
def a_multi_az_failover_has_been_triggered():
    pytest.skip("Cannot trigger internal RDS multi-AZ failover in lws")
