"""Given: the "cognito" "user" will be in "RESET_REQUIRED" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" is in "RESET_REQUIRED" state')
@given('the "cognito" "user" will be in "RESET_REQUIRED" state')
def user_is_in_reset_required_state(world):
    pytest.skip(
        "Lifecycle-dependent state (RESET_REQUIRED) is not supported "
        "in stateless integration tests."
    )
