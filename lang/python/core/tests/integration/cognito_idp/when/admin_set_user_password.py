"""When: an admin sets a "cognito" "user" password"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an admin sets a "cognito" "user" password')
def admin_set_user_password(client: TestClient, world):
    pytest.skip("AdminSetUserPassword is not yet implemented in the lws Cognito provider.")
