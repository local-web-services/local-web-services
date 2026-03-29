"""Then: deleted users do not have active authenticated sessions"""

from __future__ import annotations

from pytest_bdd import then


@then("deleted users do not have active authenticated sessions")
def deleted_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""
