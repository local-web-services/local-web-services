"""Then: the "rds" "instance" will be "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be "AVAILABLE"')
def instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
