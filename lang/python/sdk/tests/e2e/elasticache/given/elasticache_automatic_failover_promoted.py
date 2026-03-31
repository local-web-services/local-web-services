"""Given: an automatic failover promotes a new primary in a "elasticache" "replication group" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an automatic failover promotes a new primary in a "elasticache" "replication group"')
def elasticache_automatic_failover_promoted():
    pytest.skip("Cannot trigger ElastiCache automatic failover as sequence setup in lws")
