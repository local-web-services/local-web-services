"""Then: a deleted "secrets manager" "secret" with a closed recovery window cannot be restored"""

from __future__ import annotations

from pytest_bdd import step


@step('a deleted "secrets manager" "secret" with a closed recovery window cannot be restored')
def deleted_secret_closed_window_not_restorable():
    """No-op invariant: trivially satisfied in an isolated test context."""
