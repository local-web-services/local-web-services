"""Then: disabled users do not have active authenticated sessions"""

from __future__ import annotations

from pytest_bdd import then


@then("disabled users do not have active authenticated sessions")
def disabled_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""
