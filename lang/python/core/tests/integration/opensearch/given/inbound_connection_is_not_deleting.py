"""Given: the "opensearch" "inbound connection" was not "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "inbound connection" was not "DELETING"')
def inbound_connection_is_not_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
