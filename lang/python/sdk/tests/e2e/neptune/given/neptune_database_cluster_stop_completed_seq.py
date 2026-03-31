"""Given: a "neptune" "cluster" stop completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "neptune" "cluster" stop completes')
def neptune_database_cluster_stop_completed_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")
