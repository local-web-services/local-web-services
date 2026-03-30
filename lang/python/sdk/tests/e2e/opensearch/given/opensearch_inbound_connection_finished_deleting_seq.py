"""Given: an inbound connection has finished deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an inbound connection has finished deleting")
def opensearch_inbound_connection_finished_deleting_seq():
    pytest.skip("Cannot trigger internal inbound connection deletion completion in lws")
