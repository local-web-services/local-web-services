"""Then: the "rds" "instance" will be in "REBOOTING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "instance" will be in "REBOOTING" state')
def instance_is_rebooting_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
