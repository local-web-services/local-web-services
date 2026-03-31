"""Given: the "opensearch" "outbound connection" is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" is already "DELETED"')
def outbound_connection_is_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
