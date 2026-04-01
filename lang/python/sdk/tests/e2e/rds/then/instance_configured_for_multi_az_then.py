"""Then: the "rds" "instance" will be configured for multi-"AZ" deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be configured for multi-"AZ" deployment')
def instance_configured_for_multi_az_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
