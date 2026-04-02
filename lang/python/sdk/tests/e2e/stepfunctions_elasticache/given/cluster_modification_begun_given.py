"""Given: an "elasticache" "cluster" modification begins"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "cluster" modification begins')
def cluster_modification_begun_given():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
