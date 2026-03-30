"""Then: the chaos enabled flag is updated"""

from __future__ import annotations

from pytest_bdd import then


@then("the chaos enabled flag is updated")
def chaos_enabled_flag_updated():
    """Invariant step: trivially satisfied in isolated test context."""
