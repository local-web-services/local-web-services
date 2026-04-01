"""Given: a "rds" "instance" configuration is modified"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" configuration is modified')
def a_database_instance_configuration_has_been_modified():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
