"""Given: the Neptune cluster has been started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Neptune cluster has been started")
def neptune_cluster_has_been_started_seq():
    pytest.skip("Cannot start a Neptune cluster in lws")
