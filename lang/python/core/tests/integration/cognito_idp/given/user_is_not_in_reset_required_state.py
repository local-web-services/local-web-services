"""Given: the user is not in "RESET_REQUIRED" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not in "RESET_REQUIRED" state')
def user_is_not_in_reset_required_state(world):
    pytest.skip(
        "Lifecycle-dependent state check (not RESET_REQUIRED) is not supported "
        "in stateless integration tests."
    )
