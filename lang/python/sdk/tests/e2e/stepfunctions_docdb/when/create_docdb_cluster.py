"""When: a "documentdb" "cluster" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" is created')
def create_docdb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
