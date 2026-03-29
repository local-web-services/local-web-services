"""Given: a database cluster creation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster creation has failed")
def neptune_database_cluster_creation_failed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster creation failure in lws")
