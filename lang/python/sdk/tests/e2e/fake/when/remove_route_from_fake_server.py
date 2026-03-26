"""When: a route is removed from a fake server"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a route is removed from a fake server")
def remove_route_from_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
