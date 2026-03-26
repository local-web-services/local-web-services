"""Given: an admin has removed a user from a group"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an admin has removed a user from a group")
def cognito_idp_admin_removed_user_from_group():
    pytest.skip("Cannot configure Cognito user pool groups in lws")
