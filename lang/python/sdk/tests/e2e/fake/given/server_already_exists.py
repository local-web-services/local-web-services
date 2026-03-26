"""Given: the server already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the server already exists")
def server_already_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
