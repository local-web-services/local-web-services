"""Given: a database cluster snapshot deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster snapshot deletion has completed")
def docdb_snapshot_deletion_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB snapshot deletion as sequence setup in lws"
    )
