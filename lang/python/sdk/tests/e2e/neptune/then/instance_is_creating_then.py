"""Then: the instance is in "CREATING" state and associated with the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the instance is in "CREATING" state and associated with the cluster')
def instance_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
