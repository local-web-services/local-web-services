"""Given: a multi-"AZ" failover is triggered on a "neptune" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a multi-"AZ" failover is triggered on a "neptune" "cluster"')
def neptune_multi_az_failover_triggered_seq():
    pytest.skip("Cannot trigger internal Neptune multi-AZ failover in lws")
