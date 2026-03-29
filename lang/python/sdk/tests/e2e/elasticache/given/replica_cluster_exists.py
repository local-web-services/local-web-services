"""Given: a replica cluster exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replica cluster exists")
def replica_cluster_exists():
    pytest.skip("Cannot create replica cluster configuration in lws")
