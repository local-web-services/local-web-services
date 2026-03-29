"""Given: the inbound connection is not already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the inbound connection is not already "DELETED"')
def inbound_connection_is_not_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
