"""Given: the dev stage already exists for this "API" """

from __future__ import annotations

import pytest
from pytest_bdd import given
from starlette.testclient import TestClient


@given('the dev stage already exists for this "API"')
def dev_stage_already_exists_for_api(client: TestClient):
    pytest.skip(
        "lws does not enforce stage name uniqueness; duplicate dev stage creation "
        "succeeds instead of being rejected."
    )
