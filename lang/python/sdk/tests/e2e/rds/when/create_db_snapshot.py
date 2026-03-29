"""When: a database snapshot is created from an instance"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database snapshot is created from an instance")
def create_db_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
