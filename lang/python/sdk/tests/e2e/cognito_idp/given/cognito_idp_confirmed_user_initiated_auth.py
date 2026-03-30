"""Given: a confirmed enabled user has initiated authentication"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a confirmed enabled user has initiated authentication")
def cognito_idp_confirmed_user_initiated_auth():
    pytest.skip("Cannot represent a Cognito auth initiation as sequence setup in lws")
