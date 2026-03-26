"""Given: the outbound connection is already "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the outbound connection is already "DELETING"')
def outbound_connection_is_already_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
