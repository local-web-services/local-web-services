"""Given: a "rds" "instance" is restored from a "rds" "snapshot" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" is restored from a "rds" "snapshot"')
def a_database_instance_has_been_restored_from_a_snapshot():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
