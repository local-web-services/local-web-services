"""When: an outbound cross-cluster connection is created between two domains"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an outbound cross-cluster connection is created between two domains")
def create_outbound_connection(lws_session, world):
    pytest.skip("Cannot create cross-cluster connection in lws")
