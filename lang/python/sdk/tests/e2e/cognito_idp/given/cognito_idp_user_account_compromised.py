"""Given: a user account has been marked as compromised"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user account has been marked as compromised")
def cognito_idp_user_account_compromised():
    pytest.skip("Cannot mark a Cognito user as compromised in lws")
