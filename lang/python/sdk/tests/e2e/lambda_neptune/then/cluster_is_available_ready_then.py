"""Then: the "neptune" "cluster" will be "AVAILABLE" and ready to accept graph queries"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" will be "AVAILABLE" and ready to accept graph queries')
def cluster_is_available_ready_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
