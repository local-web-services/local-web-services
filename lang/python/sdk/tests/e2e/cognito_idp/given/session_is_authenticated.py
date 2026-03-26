"""Given: the session is "AUTHENTICATED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the session is "AUTHENTICATED"')
def session_is_authenticated():
    """No-op: session state is managed by Cognito auth flow."""
    pytest.skip("Cannot represent an AUTHENTICATED session as test setup in lws")
