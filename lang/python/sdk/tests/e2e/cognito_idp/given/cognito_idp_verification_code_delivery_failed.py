"""Given: a verification code delivery fails for an unconfirmed "cognito" "user" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a verification code delivery fails for an unconfirmed "cognito" "user"')
def cognito_idp_verification_code_delivery_failed():
    pytest.skip("Cannot represent verification code delivery failure as sequence setup in lws")
