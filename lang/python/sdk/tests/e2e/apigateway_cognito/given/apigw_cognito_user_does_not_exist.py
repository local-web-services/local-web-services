"""Given: the "cognito" "user" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" did not exist')
def apigw_cognito_user_does_not_exist():
    """No-op: fresh state has no users."""
