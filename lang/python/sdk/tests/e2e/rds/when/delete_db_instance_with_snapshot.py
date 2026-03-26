"""When: a database instance is deleted with a final snapshot"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database instance is deleted with a final snapshot")
def delete_db_instance_with_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
