"""Given: the "cognito" "session" was "CHALLENGE_REQUIRED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "session" was "CHALLENGE_REQUIRED"')
def session_is_challenge_required(world):
    pytest.skip(
        "Lifecycle-dependent state (CHALLENGE_REQUIRED session) is not supported "
        "in stateless integration tests."
    )
