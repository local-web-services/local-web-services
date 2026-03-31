"""When: a "rds" "instance" is rebooted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "instance" is rebooted')
def reboot_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
