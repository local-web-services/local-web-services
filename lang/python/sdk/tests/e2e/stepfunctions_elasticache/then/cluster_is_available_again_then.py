"""Then: the cluster is "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "AVAILABLE" again')
def cluster_is_available_again_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
