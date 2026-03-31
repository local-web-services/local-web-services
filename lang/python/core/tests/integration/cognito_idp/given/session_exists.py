"""Given: the "cognito" "session" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "session" existed')
def session_exists(world):
    pytest.skip(
        "Lifecycle-dependent state (existing session) is not supported "
        "in stateless integration tests."
    )
