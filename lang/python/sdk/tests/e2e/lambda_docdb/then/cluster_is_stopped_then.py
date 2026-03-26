"""Then: the cluster is "STOPPED" and connections will be rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "STOPPED" and connections will be rejected')
def cluster_is_stopped_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
