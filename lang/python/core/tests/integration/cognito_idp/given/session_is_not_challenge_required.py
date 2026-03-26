"""Given: the session is not "CHALLENGE_REQUIRED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the session is not "CHALLENGE_REQUIRED"')
def session_is_not_challenge_required(world):
    pytest.skip(
        "Lifecycle-dependent state (non-CHALLENGE_REQUIRED session) is not supported "
        "in stateless integration tests."
    )
