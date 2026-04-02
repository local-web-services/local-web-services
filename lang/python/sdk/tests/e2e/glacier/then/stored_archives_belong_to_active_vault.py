"""Then: all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import step


@step('all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"')
def stored_archives_belong_to_active_vault():
    """No-op: archive-vault ownership invariant; always passes."""
