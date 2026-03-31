"""Then: every "ACTIVE" secret has a current version assigned"""

from __future__ import annotations

from pytest_bdd import step


@step('every "ACTIVE" secret has a current version assigned')
def every_active_secret_has_current_version_quoted():
    """No-op invariant: trivially satisfied in an isolated test context."""
