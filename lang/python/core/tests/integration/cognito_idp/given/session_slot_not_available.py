"""Given: the "cognito" "session" slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "session" slot is not available')
def session_slot_not_available(world):
    pytest.skip(
        "Capacity-dependent state (no session slot) is not supported "
        "in stateless integration tests."
    )
