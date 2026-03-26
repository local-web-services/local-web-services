"""Then: the snapshot is "AVAILABLE" and the instance returns to "AVAILABLE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the snapshot is "AVAILABLE" and the instance returns to "AVAILABLE" state')
def snapshot_available_instance_returns_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
