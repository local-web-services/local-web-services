"""Given: multi-"AZ" was "ENABLED" on a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" was "ENABLED" on a "rds" "instance"')
def multi_az_has_been_enabled():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
