"""Given: a database instance has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has finished creating")
def docdb_instance_has_finished_creating():
    pytest.skip(
        "Cannot represent a completed DocumentDB instance creation as sequence setup in lws"
    )
