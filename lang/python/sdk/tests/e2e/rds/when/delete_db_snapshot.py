"""When: a database snapshot is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a database snapshot is deleted")
def delete_db_snapshot(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
