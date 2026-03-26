"""Given: cid not in cluster_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("cid not in cluster_status")
def cid_not_in_cluster_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
