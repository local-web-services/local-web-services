"""Given: an admin initiates authentication on behalf of a confirmed enabled user"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an admin initiates authentication on behalf of a confirmed enabled user")
def cognito_idp_admin_initiated_auth():
    pytest.skip("Cannot represent an admin-initiated Cognito auth as sequence setup in lws")
