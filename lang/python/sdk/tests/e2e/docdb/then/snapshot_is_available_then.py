"""Then: the "documentdb" "snapshot" will be "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "snapshot" will be "AVAILABLE"')
def snapshot_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
