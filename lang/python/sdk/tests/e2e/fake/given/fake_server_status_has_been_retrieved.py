"""Given: the status of a fake server has been retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the status of a fake server has been retrieved")
def fake_server_status_has_been_retrieved():
    pytest.skip("Fake service is not yet available in LwsSession")
