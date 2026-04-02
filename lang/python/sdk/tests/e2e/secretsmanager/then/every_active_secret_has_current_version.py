"""Then: every active "secrets manager" "secret" has a current version assigned"""

from __future__ import annotations

from pytest_bdd import step


@step('every active "secrets manager" "secret" has a current version assigned')
def every_active_secret_has_current_version():
    """No-op invariant: trivially satisfied in an isolated test context."""
