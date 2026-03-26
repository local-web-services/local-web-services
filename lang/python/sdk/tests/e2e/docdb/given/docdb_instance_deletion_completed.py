"""Given: a database instance deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance deletion has completed")
def docdb_instance_deletion_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB instance deletion as sequence setup in lws"
    )
