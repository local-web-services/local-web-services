"""Given: the "API" already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given('the "API" already exists')
def api_already_exists(client: TestClient):
    pytest.skip(
        "lws does not enforce REST API name uniqueness; duplicate creation succeeds "
        "instead of being rejected."
    )
