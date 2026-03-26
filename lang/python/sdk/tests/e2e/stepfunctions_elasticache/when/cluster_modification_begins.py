"""When: a cluster modification begins"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a cluster modification begins")
def cluster_modification_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
