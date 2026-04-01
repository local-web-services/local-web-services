"""Given: a "rds" "snapshot" is created from a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "snapshot" is created from a "rds" "instance"')
def a_database_snapshot_has_been_created_from_an_instance():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
