"""Then: the instance is "AVAILABLE" and the cluster primary is updated if applicable"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the instance is "AVAILABLE" and the cluster primary is updated if applicable')
def instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
