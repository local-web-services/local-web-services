"""Given: a database instance restore from snapshot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance restore from snapshot has completed")
def a_database_instance_restore_from_snapshot_has_completed():
    pytest.skip("Cannot trigger internal RDS instance restore completion in lws")
