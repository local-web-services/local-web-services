"""Given: a "documentdb" "instance" is created in an available documentdb cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "documentdb" "instance" is created in an available documentdb cluster')
def docdb_instance_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
