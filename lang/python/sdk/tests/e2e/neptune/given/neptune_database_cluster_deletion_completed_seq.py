"""Given: a "neptune" "cluster" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" deletion completes')
def neptune_database_cluster_deletion_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster deletion completion in lws")
