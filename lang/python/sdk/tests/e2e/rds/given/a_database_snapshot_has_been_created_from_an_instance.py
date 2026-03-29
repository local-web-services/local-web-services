"""Given: a database snapshot has been created from an instance"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database snapshot has been created from an instance")
def a_database_snapshot_has_been_created_from_an_instance():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
