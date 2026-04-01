"""Then: the "documentdb" "cluster" will be "AVAILABLE" and ready to accept connections"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "cluster" will be "AVAILABLE" and ready to accept connections')
def cluster_is_available_ready_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
