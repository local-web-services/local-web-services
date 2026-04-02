"""When: an "elasticache" "cluster" modification begins"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "elasticache" "cluster" modification begins')
def cluster_modification_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
