"""When: multi-"AZ" was "ENABLED" on a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('multi-"AZ" was "ENABLED" on a "rds" "instance"')
def enable_multi_az(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
