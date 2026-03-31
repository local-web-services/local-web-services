"""Given: a failover is triggered and a replica is promoted to primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a failover is triggered and a replica is promoted to primary")
def docdb_failover_triggered():
    pytest.skip("Cannot trigger internal DocumentDB failover as sequence setup in lws")
