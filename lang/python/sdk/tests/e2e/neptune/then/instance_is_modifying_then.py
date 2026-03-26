"""Then: the instance is in "MODIFYING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the instance is in "MODIFYING" state')
def instance_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
