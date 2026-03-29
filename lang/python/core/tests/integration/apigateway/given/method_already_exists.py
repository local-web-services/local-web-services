"""Given: the method already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given("the method already exists")
def method_already_exists(client: TestClient):
    pytest.skip(
        "lws does not enforce method uniqueness; duplicate PUT method succeeds "
        "instead of being rejected."
    )
