"""Given: a database instance configuration has been modified"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a database instance configuration has been modified")
def docdb_instance_config_modified():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
