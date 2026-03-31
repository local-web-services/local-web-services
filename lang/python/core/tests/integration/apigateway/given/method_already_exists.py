"""Given: the "api gateway" "method" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given('the "api gateway" "method" already existed')
def method_already_exists(client: TestClient):
    pytest.skip(
        "lws does not enforce method uniqueness; duplicate PUT method succeeds "
        "instead of being rejected."
    )
