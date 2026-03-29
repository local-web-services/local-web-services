"""Given: a database cluster creation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster creation has failed")
def docdb_cluster_creation_failed():
    pytest.skip("Cannot represent a failed DocumentDB cluster creation as sequence setup in lws")
