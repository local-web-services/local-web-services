"""When: a "rds" "instance" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "rds" "instance" deletion completes')
def instance_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal RDS instance deletion completion in lws")
