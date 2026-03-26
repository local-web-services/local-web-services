"""Given: the user is not in "RESET_REQUIRED" state"""

from __future__ import annotations

from pytest_bdd import given


@given('the user is not in "RESET_REQUIRED" state')
def user_is_not_in_reset_required_state():
    """No-op: freshly created users are not in RESET_REQUIRED state."""
