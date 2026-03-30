"""Then: the restored instance is in "RESTORING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the restored instance is in "RESTORING" state')
def restored_instance_is_restoring_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
