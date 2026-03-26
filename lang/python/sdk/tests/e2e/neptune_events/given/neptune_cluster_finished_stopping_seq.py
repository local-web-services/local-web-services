"""Given: the Neptune cluster has finished stopping"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Neptune cluster has finished stopping")
def neptune_cluster_finished_stopping_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
