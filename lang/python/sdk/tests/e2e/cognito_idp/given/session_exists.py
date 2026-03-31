"""Given: the "cognito" "session" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "session" existed')
def session_exists():
    """No-op: session state is managed by Cognito auth flow."""
    pytest.skip("Cannot represent an active Cognito auth session as test setup in lws")
