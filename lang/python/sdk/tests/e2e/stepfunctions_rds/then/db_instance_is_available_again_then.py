"""Then: the "DB" instance is "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "DB" instance is "AVAILABLE" again')
def db_instance_is_available_again_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
