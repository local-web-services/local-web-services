"""When: a user account is disabled by an admin"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("a user account is disabled by an admin")
def admin_disable_user(client: TestClient, world):
    pytest.skip("AdminDisableUser is not yet implemented in the lws Cognito provider.")
