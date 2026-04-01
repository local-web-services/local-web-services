"""When: an admin removes a "cognito" "user" from a "cognito" "group" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an admin removes a "cognito" "user" from a "cognito" "group"')
def admin_remove_user_from_group(client: TestClient, world):
    pytest.skip("AdminRemoveUserFromGroup is not yet implemented in the lws Cognito provider.")
