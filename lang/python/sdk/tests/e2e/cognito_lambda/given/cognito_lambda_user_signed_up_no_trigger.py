"""Given: a user has signed up to a pool that has no pre-signup trigger configured"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user has signed up to a pool that has no pre-signup trigger configured")
def cognito_lambda_user_signed_up_no_trigger():
    pytest.skip("Cannot represent a completed Cognito signup as sequence setup in lws")
