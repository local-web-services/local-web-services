"""When: a user responds to an auth challenge"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import CognitoIdpTestClient
from ..constants import INT_CLIENT_ID, INT_PASSWORD, INT_USERNAME, _store


@when("a user responds to an auth challenge")
def respond_to_auth_challenge(client: TestClient, world):
    session_id = world.get("session_id", "nonexistent-session")
    r = CognitoIdpTestClient(client).cognito_post(
        "RespondToAuthChallenge",
        {
            "ClientId": INT_CLIENT_ID,
            "ChallengeName": "PASSWORD_VERIFIER",
            "Session": session_id,
            "ChallengeResponses": {"USERNAME": INT_USERNAME, "PASSWORD": INT_PASSWORD},
        },
    )
    _store(world, r)
