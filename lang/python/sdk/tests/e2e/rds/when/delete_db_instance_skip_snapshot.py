"""When: a "rds" "instance" is deleted without a final "rds" "snapshot" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "instance" is deleted without a final "rds" "snapshot"')
def delete_db_instance_skip_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
