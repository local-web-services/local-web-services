"""Given: the "cognito" "user" did not have an enabled flag"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" did not have an enabled flag')
def user_does_not_have_enabled_flag():
    """No-op: all Cognito users have an enabled flag; this represents a non-existent user."""
    pytest.skip("Cannot represent a Cognito user without an enabled flag (all users have one)")
