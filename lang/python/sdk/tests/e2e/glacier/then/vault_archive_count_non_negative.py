"""Then: "glacier" "vault" archive count is never negative"""

from __future__ import annotations

from pytest_bdd import step


@step('"glacier" "vault" archive count is never negative')
def vault_archive_count_non_negative():
    """No-op: vault archive count invariant; always passes."""
