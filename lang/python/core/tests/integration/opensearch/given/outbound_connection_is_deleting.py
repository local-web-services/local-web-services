"""Given: the "opensearch" "outbound connection" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" was "DELETING"')
def outbound_connection_is_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
