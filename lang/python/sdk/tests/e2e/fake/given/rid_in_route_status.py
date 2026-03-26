"""Given: rid in route_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("rid in route_status")
def rid_in_route_status():
    pytest.skip("Fake service is not yet available in LwsSession")
