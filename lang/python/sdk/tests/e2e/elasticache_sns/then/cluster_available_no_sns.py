"""Then: the cluster is "AVAILABLE" with no "SNS" notification configured"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "AVAILABLE" with no "SNS" notification configured')
def cluster_available_no_sns(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
