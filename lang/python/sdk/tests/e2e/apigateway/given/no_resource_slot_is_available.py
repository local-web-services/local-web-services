"""Given: no resource slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no resource slot is available")
def no_resource_slot_is_available(lws_session):
    """Skip: lws does not enforce resource-slot capacity limits on CreateRestApi."""
    pytest.skip("lws does not enforce resource-slot capacity limits on CreateRestApi")
