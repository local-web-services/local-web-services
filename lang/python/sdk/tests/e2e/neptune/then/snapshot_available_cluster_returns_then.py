"""Then: the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" if it was backing up"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" if it was backing up')
def snapshot_available_cluster_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
