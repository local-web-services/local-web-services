"""Given: an inbound cross-cluster connection is rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an inbound cross-cluster connection is rejected")
def opensearch_inbound_connection_rejected_seq():
    pytest.skip("Cannot reject inbound cross-cluster connection in lws")
