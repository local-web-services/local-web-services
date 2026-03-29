"""Given: a database cluster stop has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database cluster stop has completed")
def neptune_database_cluster_stop_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
