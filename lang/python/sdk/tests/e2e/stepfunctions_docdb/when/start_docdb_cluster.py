"""When: the "documentdb" "cluster" is started"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "documentdb" "cluster" is started')
def start_docdb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
