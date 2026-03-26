"""Given: a DocumentDB cluster has been created and has become "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a DocumentDB cluster has been created and has become "AVAILABLE"')
def docdb_events_cluster_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
