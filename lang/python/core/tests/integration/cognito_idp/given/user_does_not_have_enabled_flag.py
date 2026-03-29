"""Given: the user does not have an enabled flag"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the user does not have an enabled flag")
def user_does_not_have_enabled_flag(world):
    pytest.skip(
        "Lifecycle-dependent state (user without enabled flag) is not supported "
        "in stateless integration tests."
    )
