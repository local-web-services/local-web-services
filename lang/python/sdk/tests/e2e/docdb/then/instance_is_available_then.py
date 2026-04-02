"""Then: the "documentdb" "instance" will be "AVAILABLE" and the "documentdb" "cluster" primary will be updated if applicable"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "documentdb" "instance" will be "AVAILABLE" and the "documentdb" "cluster" primary will be updated if applicable'
)
def instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
