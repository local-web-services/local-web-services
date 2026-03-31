"""Given: an admin resets a "cognito" "user" password"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an admin resets a "cognito" "user" password')
def cognito_idp_admin_reset_password():
    pytest.skip("Cannot represent an admin password reset as sequence setup in lws")
