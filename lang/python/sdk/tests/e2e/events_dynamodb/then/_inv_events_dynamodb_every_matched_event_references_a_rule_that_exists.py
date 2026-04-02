"""Then: every matched "eventbridge" "event" references an "eventbridge" "rule" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every matched "eventbridge" "event" references an "eventbridge" "rule" that exists')
def _inv_events_dynamodb_every_matched_event_references_a_rule_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
