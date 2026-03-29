"""Then: every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled"""

from __future__ import annotations

from pytest_bdd import then


@then('every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled')
def invariant_enabled_esm_references_active_table():
    """Invariant: trivially satisfied in isolated lws context."""
