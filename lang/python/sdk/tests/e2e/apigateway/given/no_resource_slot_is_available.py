"""Given: no "api gateway" "resource" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "api gateway" "resource" "slot" was "available"')
def no_resource_slot_is_available(lws_session):
    """Skip: lws does not enforce resource-slot capacity limits on CreateRestApi."""
    pytest.skip("lws does not enforce resource-slot capacity limits on CreateRestApi")
