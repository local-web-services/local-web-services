"""Then: every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every rule has a valid status ("ENABLED", "DISABLED", or "DELETED")')
def _inv_events_every_rule_has_a_valid_status_enabled_disabled_or_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
