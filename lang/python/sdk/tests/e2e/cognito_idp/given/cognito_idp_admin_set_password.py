"""Given: an admin sets a "cognito" "user" password"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an admin sets a "cognito" "user" password')
def cognito_idp_admin_set_password():
    pytest.skip("Cannot represent an admin password set as sequence setup in lws")
