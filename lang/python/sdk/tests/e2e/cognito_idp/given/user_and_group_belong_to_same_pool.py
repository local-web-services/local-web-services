"""Given: the "cognito" "user" and group belonged to the same pool"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" and group belonged to the same pool')
def user_and_group_belong_to_same_pool():
    """No-op: user and group are created in the same pool by default."""
