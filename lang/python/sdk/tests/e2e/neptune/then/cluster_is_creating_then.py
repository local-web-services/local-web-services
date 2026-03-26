"""Then: the cluster is in "CREATING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is in "CREATING" state')
def cluster_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
