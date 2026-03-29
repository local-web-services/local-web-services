"""Then: the cluster remains "AVAILABLE" after the shard failover"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster remains "AVAILABLE" after the shard failover')
def cluster_remains_available_after_failover_then():
    pytest.skip("Cannot observe internal cluster failover in lws")
