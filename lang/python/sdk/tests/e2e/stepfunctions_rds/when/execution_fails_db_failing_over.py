"""When: a running execution fails to query the "DB" because it is failing over"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution fails to query the "DB" because it is failing over')
def execution_fails_db_failing_over(world):
    pytest.skip("Cannot trigger internal execution step that fails due to RDS DB failover in lws")
