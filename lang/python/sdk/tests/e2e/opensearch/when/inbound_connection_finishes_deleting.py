"""When: an inbound connection finishes deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an inbound connection finishes deleting")
def inbound_connection_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal inbound connection deletion completion in lws")
