"""Given: conn in outbound_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("conn in outbound_status")
def conn_in_outbound_status():
    pytest.skip("Cannot create an outbound connection as a FizzBee precondition in this context")
