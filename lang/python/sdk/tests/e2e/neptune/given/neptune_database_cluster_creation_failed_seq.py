"""Given: a "neptune" "cluster" creation fails"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" creation fails')
def neptune_database_cluster_creation_failed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster creation failure in lws")
