"""Given: a failover has been triggered and a replica has been promoted to primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a failover has been triggered and a replica has been promoted to primary")
def docdb_failover_triggered():
    pytest.skip("Cannot trigger internal DocumentDB failover as sequence setup in lws")
