"""Given: the inbound connection is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the inbound connection is already "DELETED"')
def inbound_connection_is_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
