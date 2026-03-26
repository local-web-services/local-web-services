"""Given: a route has been added to a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a route has been added to a fake server")
def fake_route_has_been_added():
    pytest.skip("Fake service is not yet available in LwsSession")
