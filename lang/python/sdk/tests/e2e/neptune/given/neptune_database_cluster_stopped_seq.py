"""Given: a database cluster has been stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster has been stopped")
def neptune_database_cluster_stopped_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop in lws")
