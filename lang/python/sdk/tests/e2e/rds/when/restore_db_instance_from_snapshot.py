"""When: a "rds" "instance" is restored from a "rds" "snapshot" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "instance" is restored from a "rds" "snapshot"')
def restore_db_instance_from_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
