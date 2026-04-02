"""Given: the "elasticache" "parameter group" was not "present" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticache" "parameter group" was not "present"')
def pg_is_not_present(world):
    world["_skip"] = "lws cluster_db_service does not implement boto3 RDS query protocol"
    pytest.skip(world["_skip"])
