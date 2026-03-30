"""When: an authenticated session expires"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import _store


@when("an authenticated session expires")
def expire_auth_session(client: TestClient, world):
    session_id = world.get("session_id", "nonexistent-session")
    r = CognitoIdpTestClient(client).cognito_post("GlobalSignOut", {"AccessToken": session_id})
    _store(world, r)
