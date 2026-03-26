"""Given: the session exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the session exists")
def session_exists(world):
    pytest.skip(
        "Lifecycle-dependent state (existing session) is not supported "
        "in stateless integration tests."
    )
