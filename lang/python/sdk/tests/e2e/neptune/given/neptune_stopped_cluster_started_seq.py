"""Given: a stopped database cluster has been started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a stopped database cluster has been started")
def neptune_stopped_cluster_started_seq():
    pytest.skip("Cannot trigger internal Neptune cluster start in lws")
