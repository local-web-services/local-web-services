"""Given: a fake server has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a fake server has been deleted")
def fake_server_has_been_deleted():
    pytest.skip("Fake service is not yet available in LwsSession")
