"""Given: the route is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the route is not "ACTIVE"')
def route_is_not_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
