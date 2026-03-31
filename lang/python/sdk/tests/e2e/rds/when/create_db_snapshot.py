"""When: a "rds" "snapshot" is created from a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "snapshot" is created from a "rds" "instance"')
def create_db_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
