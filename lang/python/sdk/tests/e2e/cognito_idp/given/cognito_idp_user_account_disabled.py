"""Given: a user account has been disabled by an admin"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user account has been disabled by an admin")
def cognito_idp_user_account_disabled():
    pytest.skip("Cannot represent a disabled Cognito user as sequence setup in lws")
