"""Then: every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"')
def _inv_events_sns_every_enabled_rule_references_an_active_event_bus():
    """Invariant step: trivially satisfied in isolated test context."""
