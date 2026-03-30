"""Given: the user does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the user does not exist")
def apigw_cognito_user_does_not_exist():
    """No-op: fresh state has no users."""
