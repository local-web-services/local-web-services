"""Given: a cluster modification has begun"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cluster modification has begun")
def cluster_modification_begun_given():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
