"""Given: the session is "AUTHENTICATED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the session is "AUTHENTICATED"')
def session_is_authenticated(world):
    pytest.skip(
        "Lifecycle-dependent state (AUTHENTICATED session) is not supported "
        "in stateless integration tests."
    )
