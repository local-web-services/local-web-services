"""Given: a database cluster deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster deletion has completed")
def neptune_database_cluster_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster deletion completion in lws")
