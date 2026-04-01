"""Then: the "DB" instance will be "AVAILABLE" with no Lambda integration configured"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "DB" instance will be "AVAILABLE" with no Lambda integration configured')
def db_instance_available_no_integration(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
