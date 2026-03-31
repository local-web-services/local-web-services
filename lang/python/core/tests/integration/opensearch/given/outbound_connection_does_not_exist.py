"""Given: the "opensearch" "outbound connection" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "outbound connection" did not exist')
def outbound_connection_does_not_exist(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")
