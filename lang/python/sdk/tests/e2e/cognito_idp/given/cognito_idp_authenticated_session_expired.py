"""Given: an authenticated session has expired"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an authenticated session has expired")
def cognito_idp_authenticated_session_expired():
    pytest.skip("Cannot represent an expired Cognito auth session as sequence setup in lws")
