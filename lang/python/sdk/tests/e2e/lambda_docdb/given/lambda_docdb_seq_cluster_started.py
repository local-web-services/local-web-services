"""Given: the DocumentDB cluster has been started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the DocumentDB cluster has been started")
def lambda_docdb_seq_cluster_started():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
