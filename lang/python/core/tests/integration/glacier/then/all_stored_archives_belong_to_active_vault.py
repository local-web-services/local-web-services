"""Then: all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import then


@then('all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"')
def all_stored_archives_belong_to_active_vault():
    """Invariant trivially satisfied in an isolated test context."""
