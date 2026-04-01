"""When: an admin updates attributes for a confirmed user"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an admin updates attributes for a confirmed user")
def admin_update_user_attributes(client: TestClient, world):
    pytest.skip("AdminUpdateUserAttributes is not yet implemented in the lws Cognito provider.")
