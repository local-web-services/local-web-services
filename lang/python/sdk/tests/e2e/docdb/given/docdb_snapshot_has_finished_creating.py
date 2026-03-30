"""Given: a database cluster snapshot has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster snapshot has finished creating")
def docdb_snapshot_has_finished_creating():
    pytest.skip(
        "Cannot represent a completed DocumentDB snapshot creation as sequence setup in lws"
    )
