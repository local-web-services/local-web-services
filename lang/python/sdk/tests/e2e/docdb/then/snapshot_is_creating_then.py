"""Then: the snapshot is in "CREATING" state and linked to the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is in "CREATING" state and linked to the cluster')
def snapshot_is_creating_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
