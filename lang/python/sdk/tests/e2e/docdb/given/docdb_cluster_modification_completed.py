"""Given: a database cluster modification has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster modification has completed")
def docdb_cluster_modification_completed():
    pytest.skip(
        "Cannot represent a completed DocumentDB cluster modification as sequence setup in lws"
    )
