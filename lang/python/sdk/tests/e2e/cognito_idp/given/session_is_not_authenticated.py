"""Given: the session is not "AUTHENTICATED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the session is not "AUTHENTICATED"')
def session_is_not_authenticated():
    """No-op: fresh state has no sessions."""
    pytest.skip("Cannot represent a non-AUTHENTICATED session as test setup in lws")
