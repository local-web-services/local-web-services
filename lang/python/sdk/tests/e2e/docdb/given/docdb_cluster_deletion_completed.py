"""Given: a database cluster deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster deletion has completed")
def docdb_cluster_deletion_completed():
    pytest.skip("Cannot represent a completed DocumentDB cluster deletion as sequence setup in lws")
