"""Given: the "memorydb" "cluster" was not "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "cluster" was not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE MemoryDB cluster lifecycle states")
