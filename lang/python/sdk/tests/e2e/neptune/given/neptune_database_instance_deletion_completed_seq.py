"""Given: a database instance deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance deletion has completed")
def neptune_database_instance_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune instance deletion completion in lws")
