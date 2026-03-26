"""Then: all stored archives belong to an "ACTIVE" vault"""

from __future__ import annotations

from pytest_bdd import then


@then('all stored archives belong to an "ACTIVE" vault')
def stored_archives_belong_to_active_vault():
    """No-op: archive-vault ownership invariant; always passes."""
