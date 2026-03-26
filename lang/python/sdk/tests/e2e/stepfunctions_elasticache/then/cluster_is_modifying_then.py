"""Then: the cluster is "MODIFYING" and connections may be refused"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "MODIFYING" and connections may be refused')
def cluster_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
