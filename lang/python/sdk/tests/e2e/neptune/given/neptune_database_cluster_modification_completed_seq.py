"""Given: a "neptune" "cluster" modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" modification completes')
def neptune_database_cluster_modification_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster modification completion in lws")
