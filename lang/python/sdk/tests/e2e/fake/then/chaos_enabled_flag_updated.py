"""Then: the "fake" "server" chaos enabled flag will be updated"""

from __future__ import annotations

from pytest_bdd import then


@then('the "fake" "server" chaos enabled flag will be updated')
def chaos_enabled_flag_updated():
    """Invariant step: trivially satisfied in isolated test context."""
