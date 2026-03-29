"""Given: an outbound cross-cluster connection has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an outbound cross-cluster connection has been deleted")
def opensearch_outbound_connection_deleted_seq():
    pytest.skip("Cannot delete cross-cluster connection in lws")
