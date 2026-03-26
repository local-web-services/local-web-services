"""When: a replication group finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replication group finishes creating")
def rg_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replication group creation completion in lws")
