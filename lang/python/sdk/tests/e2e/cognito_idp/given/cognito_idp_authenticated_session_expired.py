"""Given: an authenticated "cognito" "session" expires"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an authenticated "cognito" "session" expires')
def cognito_idp_authenticated_session_expired():
    pytest.skip("Cannot represent an expired Cognito auth session as sequence setup in lws")
