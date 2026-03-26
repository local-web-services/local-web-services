"""Given: conn in inbound_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("conn in inbound_status")
def conn_in_inbound_status():
    pytest.skip("Cannot create an inbound connection as a FizzBee precondition in this context")
