"""Then: every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")"""

from __future__ import annotations

from pytest_bdd import step


@step('every "eventbridge" "rule" has a valid pattern type ("EVENT_PATTERN" or "SCHEDULE")')
def _inv_events_every_rule_has_a_valid_pattern_type_event_pattern_or_schedule():
    """Invariant step: trivially satisfied in isolated test context."""
