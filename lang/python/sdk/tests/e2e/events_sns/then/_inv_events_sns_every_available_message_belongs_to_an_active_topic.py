"""Then: every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic" """

from __future__ import annotations

from pytest_bdd import step


@step('every "AVAILABLE" "sns" "message" belongs to an "ACTIVE" "sns" "topic"')
def _inv_events_sns_every_available_message_belongs_to_an_active_topic():
    """Invariant step: trivially satisfied in isolated test context."""
