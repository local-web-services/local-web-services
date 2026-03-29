"""When: an admin resets a user password"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an admin resets a user password")
def admin_reset_user_password(client: TestClient, world):
    pytest.skip("AdminResetUserPassword is not yet implemented in the lws Cognito provider.")
