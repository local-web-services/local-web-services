"""Given: the "neptune" "cluster" was not "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "cluster" was not "STOPPED"')
def neptune_cluster_has_been_stopped():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
