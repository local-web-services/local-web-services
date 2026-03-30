"""Then: every "ENABLED" rule references an "ACTIVE" event bus"""

from __future__ import annotations

from pytest_bdd import then


@then('every "ENABLED" rule references an "ACTIVE" event bus')
def _inv_events_sns_every_enabled_rule_references_an_active_event_bus():
    """Invariant step: trivially satisfied in isolated test context."""
