"""When: an inbound cross-cluster connection is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an inbound cross-cluster connection is deleted")
def delete_inbound_connection(lws_session, world):
    pytest.skip("Cannot delete inbound cross-cluster connection in lws")
