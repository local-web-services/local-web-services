"""Given: a fake server has been created"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a fake server has been created")
def fake_server_has_been_created():
    pytest.skip("Fake service is not yet available in LwsSession")
