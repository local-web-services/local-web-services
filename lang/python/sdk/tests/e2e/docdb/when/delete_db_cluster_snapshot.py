"""When: a "documentdb" "cluster" documentdb snapshot is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" documentdb snapshot is deleted')
def delete_db_cluster_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
