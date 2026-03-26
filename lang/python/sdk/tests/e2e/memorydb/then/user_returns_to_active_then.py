"""Then: the user returns to "ACTIVE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the user returns to "ACTIVE" state')
def user_returns_to_active_then():
    pytest.skip("Cannot observe internal user state transition in lws")
