"""Given: a "rds" "instance" is rebooted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "rds" "instance" is rebooted')
def a_database_instance_has_been_rebooted():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
