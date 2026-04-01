"""Given: a "cognito" "user" was "ENABLED" by an admin"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user" was "ENABLED" by an admin')
def cognito_idp_user_account_enabled():
    pytest.skip("Cannot represent an enabled Cognito user as sequence setup in lws")
