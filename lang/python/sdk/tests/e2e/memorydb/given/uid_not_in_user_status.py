"""Given: uid not in user_status"""

from __future__ import annotations

from pytest_bdd import given


@given("uid not in user_status")
def uid_not_in_user_status():
    """No-op: fresh state has no users."""
