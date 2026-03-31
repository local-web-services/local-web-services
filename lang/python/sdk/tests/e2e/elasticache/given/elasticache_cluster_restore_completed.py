"""Given: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticache" "cluster" restore from "elasticache" "snapshot" completes')
def elasticache_cluster_restore_completed():
    pytest.skip("Cannot represent a completed ElastiCache restore as sequence setup in lws")
