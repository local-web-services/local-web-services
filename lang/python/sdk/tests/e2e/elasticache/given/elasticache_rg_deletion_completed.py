"""Given: a "elasticache" "replication group" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "elasticache" "replication group" deletion completes')
def elasticache_rg_deletion_completed():
    pytest.skip(
        "Cannot represent a completed ElastiCache replication group deletion as sequence setup in lws"  # noqa: E501
    )
