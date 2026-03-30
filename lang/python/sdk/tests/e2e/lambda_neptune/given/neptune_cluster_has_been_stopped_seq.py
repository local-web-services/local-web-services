"""Given: the Neptune cluster has been stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Neptune cluster has been stopped")
def neptune_cluster_has_been_stopped_seq():
    pytest.skip("Cannot stop a Neptune cluster in lws")
