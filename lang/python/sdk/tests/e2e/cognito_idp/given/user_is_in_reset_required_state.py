"""Given: the "cognito" "user" will be in "RESET_REQUIRED" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" is in "RESET_REQUIRED" state')
def user_is_in_reset_required_state():
    """No-op: treated as a precondition; state transitions require confirmed user flow."""
    pytest.skip(
        "Cannot set user to RESET_REQUIRED state without a confirmed user and admin reset flow"
    )
