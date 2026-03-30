"""Given: cid in cluster_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("cid in cluster_status")
def cid_in_cluster_status():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
