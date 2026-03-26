"""Given: dbid in db_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("dbid in db_status")
def dbid_in_db_status():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
