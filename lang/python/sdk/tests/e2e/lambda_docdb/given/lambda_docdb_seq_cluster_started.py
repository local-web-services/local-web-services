"""Given: the "documentdb" "cluster" is started"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" is started')
def lambda_docdb_seq_cluster_started():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
