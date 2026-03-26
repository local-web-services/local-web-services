"""Given: a replication group deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a replication group deletion has completed")
def elasticache_rg_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache replication group deletion as sequence setup in lws"  # noqa: E501
    )
