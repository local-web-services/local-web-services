"""When: a Multi-"AZ" failover begins on the "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a Multi-"AZ" failover begins on the "rds" "instance"')
def rds_failover_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
