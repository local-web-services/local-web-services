"""Given: a "neptune" "cluster" start completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" start completes')
def neptune_database_cluster_start_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster start completion in lws")
