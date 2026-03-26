"""When: a route is added to a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a route is added to a fake server")
def add_route_to_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
