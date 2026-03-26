"""Given: the route exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the route exists")
def route_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
