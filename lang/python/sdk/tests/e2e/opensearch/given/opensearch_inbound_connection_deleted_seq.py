"""Given: an inbound cross-cluster connection is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an inbound cross-cluster connection is deleted")
def opensearch_inbound_connection_deleted_seq():
    pytest.skip("Cannot delete inbound cross-cluster connection in lws")
