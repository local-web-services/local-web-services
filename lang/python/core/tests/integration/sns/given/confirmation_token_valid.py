"""Given: the confirmation token is valid"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the confirmation token is valid")
def confirmation_token_valid():
    pytest.skip("Cannot control confirmation token validity in integration test context")
