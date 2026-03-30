"""When: an "RDS" "DB" instance is created and becomes "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "RDS" "DB" instance is created and becomes "AVAILABLE"')
def create_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
