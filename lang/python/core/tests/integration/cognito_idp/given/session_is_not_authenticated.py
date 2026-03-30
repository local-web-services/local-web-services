"""Given: the session is not "AUTHENTICATED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the session is not "AUTHENTICATED"')
def session_is_not_authenticated(world):
    pytest.skip(
        "Lifecycle-dependent state (non-AUTHENTICATED session) is not supported "
        "in stateless integration tests."
    )
