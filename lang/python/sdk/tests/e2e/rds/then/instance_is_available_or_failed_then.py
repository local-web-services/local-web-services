"""Then: the "rds" "instance" will be "AVAILABLE" or "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
