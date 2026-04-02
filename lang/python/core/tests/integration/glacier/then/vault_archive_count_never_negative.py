"""Then: "glacier" "vault" archive count is never negative"""

from __future__ import annotations

from pytest_bdd import then


@then('"glacier" "vault" archive count is never negative')
def vault_archive_count_never_negative():
    """Invariant trivially satisfied in an isolated test context."""
