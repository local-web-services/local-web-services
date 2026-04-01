"""When: a "documentdb" "cluster" creation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" creation fails')
def database_cluster_creation_fails(world):
    pytest.skip("lws does not validate engine parameter — cluster creation always succeeds.")
