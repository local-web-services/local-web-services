"""Given: a "documentdb" "cluster" is created and becomes "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "cluster" is created and becomes "AVAILABLE"')
def docdb_events_cluster_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
