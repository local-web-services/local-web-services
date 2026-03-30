"""Given: a cache cluster restore from snapshot has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a cache cluster restore from snapshot has completed")
def elasticache_cluster_restore_completed():
    pytest.skip("Cannot represent a completed ElastiCache restore as sequence setup in lws")
