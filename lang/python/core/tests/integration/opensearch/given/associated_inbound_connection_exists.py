"""Given: the associated inbound connection exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the associated inbound connection exists")
def associated_inbound_connection_exists(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
