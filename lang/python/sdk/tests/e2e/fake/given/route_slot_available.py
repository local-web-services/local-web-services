"""Given: a route slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a route slot is available")
def route_slot_available():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
