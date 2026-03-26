"""Given: the user is not enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user is not enabled")
def user_is_not_enabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )
