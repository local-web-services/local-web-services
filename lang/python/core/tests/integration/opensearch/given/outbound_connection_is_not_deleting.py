"""Given: the outbound connection is not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the outbound connection is not "DELETING"')
def outbound_connection_is_not_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
