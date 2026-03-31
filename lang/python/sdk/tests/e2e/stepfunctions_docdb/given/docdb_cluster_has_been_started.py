"""Given: the "documentdb" "cluster" is started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" is started')
def docdb_cluster_has_been_started():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
