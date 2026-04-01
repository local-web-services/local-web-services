"""Given: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an admin adds a "cognito" "user" to a "cognito" "group" in the same pool')
def cognito_idp_admin_added_user_to_group():
    pytest.skip("Cannot configure Cognito user pool groups in lws")
