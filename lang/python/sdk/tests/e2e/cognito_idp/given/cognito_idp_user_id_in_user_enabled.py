"""Given: user_id in user_enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("user_id in user_enabled")
def cognito_idp_user_id_in_user_enabled():
    pytest.skip("Cannot represent an enabled Cognito user as sequence setup in lws")
