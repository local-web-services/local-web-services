"""Given: a subscription confirmation token has expired"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a subscription confirmation token has expired")
def sns_a_subscription_confirmation_token_has_expired():
    pytest.skip("Cannot simulate token expiry in lws")
