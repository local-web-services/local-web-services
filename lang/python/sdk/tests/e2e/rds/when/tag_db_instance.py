"""When: a tag is applied to a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a tag is applied to a "rds" "instance"')
def tag_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
