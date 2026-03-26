"""Given: a route has been removed from a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a route has been removed from a fake server")
def fake_route_has_been_removed():
    pytest.skip("Fake service is not yet available in LwsSession")
