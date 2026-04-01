"""Given: the "cognito" "user" is in "FORCE_CHANGE_PASSWORD" state"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" is in "FORCE_CHANGE_PASSWORD" state')
def user_is_in_force_change_password_state():
    """No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD by default."""
