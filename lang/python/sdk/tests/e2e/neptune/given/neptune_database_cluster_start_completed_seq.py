"""Given: a database cluster start has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster start has completed")
def neptune_database_cluster_start_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster start completion in lws")
