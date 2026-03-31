"""When: a "cognito" "user" was "ENABLED" by an admin"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "cognito" "user" was "ENABLED" by an admin')
def admin_enable_user(client: TestClient, world):
    pytest.skip("AdminEnableUser is not yet implemented in the lws Cognito provider.")
