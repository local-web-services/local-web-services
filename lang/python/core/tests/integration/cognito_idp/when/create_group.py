"""When: a group is created in an active user pool"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a group is created in an active user pool")
def create_group(client: TestClient, world):
    pytest.skip("CreateGroup is not yet implemented in the lws Cognito provider.")
