"""Given: a database cluster has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster has finished creating")
def neptune_database_cluster_finished_creating_seq():
    pytest.skip("Cannot trigger internal Neptune cluster creation completion in lws")
