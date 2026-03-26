"""Given: sid in server_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("sid in server_status")
def sid_in_server_status():
    pytest.skip("Fake service is not yet available in LwsSession")
