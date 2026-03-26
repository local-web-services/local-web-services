"""When: an admin adds a user to a group in the same pool"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an admin adds a user to a group in the same pool")
def admin_add_user_to_group(client: TestClient, world):
    pytest.skip("AdminAddUserToGroup is not yet implemented in the lws Cognito provider.")
