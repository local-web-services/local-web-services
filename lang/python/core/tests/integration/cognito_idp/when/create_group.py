"""When: a "cognito" "group" is created in an active "cognito" "user pool" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "cognito" "group" is created in an active "cognito" "user pool"')
def create_group(client: TestClient, world):
    pytest.skip("CreateGroup is not yet implemented in the lws Cognito provider.")
