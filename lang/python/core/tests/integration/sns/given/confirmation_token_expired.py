"""Given: the confirmation token has expired"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the confirmation token has expired")
def confirmation_token_expired():
    pytest.skip("Cannot control confirmation token expiry in integration test context")
