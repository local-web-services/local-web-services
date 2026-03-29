"""Given: a user has responded to an auth challenge"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user has responded to an auth challenge")
def cognito_idp_user_responded_to_challenge():
    pytest.skip("Cannot represent an auth challenge response as sequence setup in lws")
