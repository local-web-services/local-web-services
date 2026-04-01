"""Given: the "cognito" "session" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "session" slot is available')
def session_slot_available():
    """No-op: session slots are always available in isolated tests."""
