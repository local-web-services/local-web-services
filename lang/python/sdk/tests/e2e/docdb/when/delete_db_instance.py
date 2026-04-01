"""When: a "documentdb" "instance" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "instance" is deleted')
def delete_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
