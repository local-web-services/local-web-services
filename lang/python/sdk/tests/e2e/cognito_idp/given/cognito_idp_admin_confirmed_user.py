"""Given: an admin confirms a "cognito" "user" registration"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an admin confirms a "cognito" "user" registration')
def cognito_idp_admin_confirmed_user():
    pytest.skip("Cannot represent an admin-confirmed Cognito user as sequence setup in lws")
