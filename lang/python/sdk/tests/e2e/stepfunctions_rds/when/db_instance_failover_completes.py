"""When: the "DB" instance failover completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "DB" instance failover completes')
def db_instance_failover_completes(world):
    pytest.skip("Cannot trigger internal RDS DB instance failover completion in lws")
