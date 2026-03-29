"""Given: cid in cluster_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("cid in cluster_status")
def cid_in_cluster_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
