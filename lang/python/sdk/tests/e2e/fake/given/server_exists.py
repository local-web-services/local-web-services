"""Given: the server exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the server exists")
def server_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
