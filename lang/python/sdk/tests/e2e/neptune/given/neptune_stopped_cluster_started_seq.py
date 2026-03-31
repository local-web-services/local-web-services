"""Given: a stopped neptune database neptune cluster is started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a stopped neptune database neptune cluster is started")
def neptune_stopped_cluster_started_seq():
    pytest.skip("Cannot trigger internal Neptune cluster start in lws")
