"""Given: a database instance has been rebooted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance has been rebooted")
def a_database_instance_has_been_rebooted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
