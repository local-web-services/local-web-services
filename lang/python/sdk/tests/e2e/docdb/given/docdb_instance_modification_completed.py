"""Given: a database instance modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance modification has completed")
def docdb_instance_modification_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB instance modification as sequence setup in lws"
    )
