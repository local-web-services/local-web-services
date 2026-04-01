"""When: an admin initiates authentication on behalf of a confirmed enabled user"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an admin initiates authentication on behalf of a confirmed enabled user")
def admin_initiate_auth(client: TestClient, world):
    pytest.skip("AdminInitiateAuth is not yet implemented in the lws Cognito provider.")
