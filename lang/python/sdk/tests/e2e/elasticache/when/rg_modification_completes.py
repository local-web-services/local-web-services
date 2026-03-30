"""When: a replication group modification completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replication group modification completes")
def rg_modification_completes(lws_session, world):
    pytest.skip(
        "Cannot trigger internal ElastiCache replication group modification completion in lws"
    )
