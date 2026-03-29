"""Given: the user is disabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user is disabled")
def user_is_disabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )
