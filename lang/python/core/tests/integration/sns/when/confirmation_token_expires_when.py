"""When: the confirmation token expires"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the confirmation token expires")
def confirmation_token_expires_when(world):
    pytest.skip("Cannot expire confirmation token in integration test context")
