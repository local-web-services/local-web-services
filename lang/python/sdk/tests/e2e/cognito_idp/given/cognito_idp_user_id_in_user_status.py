"""Given: user_id in user_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("user_id in user_status")
def cognito_idp_user_id_in_user_status():
    pytest.skip("Cannot represent a Cognito user status as sequence setup in lws")
