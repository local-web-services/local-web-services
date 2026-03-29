"""Given: the cluster is not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE ElastiCache cluster lifecycle states")
