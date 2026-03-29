"""When: a replication group deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replication group deletion completes")
def rg_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache replication group deletion completion in lws")
