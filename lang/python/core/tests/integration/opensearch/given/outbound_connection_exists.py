"""Given: the outbound connection exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the outbound connection exists")
def outbound_connection_exists(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
