"""Given: an admin has reset a user password"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an admin has reset a user password")
def cognito_idp_admin_reset_password():
    pytest.skip("Cannot represent an admin password reset as sequence setup in lws")
