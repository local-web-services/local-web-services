"""Given: the "documentdb" "cluster" was not "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "cluster" was not "STOPPED"')
def lambda_docdb_seq_cluster_stopped():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
