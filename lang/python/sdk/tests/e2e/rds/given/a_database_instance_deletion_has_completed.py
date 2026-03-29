"""Given: a database instance deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance deletion has completed")
def a_database_instance_deletion_has_completed():
    pytest.skip("Cannot trigger internal RDS instance deletion completion in lws")
