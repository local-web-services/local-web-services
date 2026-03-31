"""When: a "neptune" "cluster" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "neptune" "cluster" is created')
def create_neptune_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
