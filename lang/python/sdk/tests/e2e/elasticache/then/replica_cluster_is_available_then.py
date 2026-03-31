"""Then: the replica "elasticache" "cluster" will be "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the replica "elasticache" "cluster" will be "AVAILABLE"')
def replica_cluster_is_available_then():
    pytest.skip("Cannot observe internal replica cluster creation in lws")
