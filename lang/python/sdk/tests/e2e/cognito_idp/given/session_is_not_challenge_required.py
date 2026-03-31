"""Given: the "cognito" "session" was not "CHALLENGE_REQUIRED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "session" was not "CHALLENGE_REQUIRED"')
def session_is_not_challenge_required():
    """No-op: session state is managed by Cognito auth flow."""
    pytest.skip("Cannot represent a non-CHALLENGE_REQUIRED session as test setup in lws")
