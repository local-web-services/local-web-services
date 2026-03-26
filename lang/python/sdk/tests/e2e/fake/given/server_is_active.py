"""Given: the server is "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the server is "ACTIVE"')
def server_is_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")
