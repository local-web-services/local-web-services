"""Given: the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"')
def inbound_connection_is_not_pending_acceptance(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
