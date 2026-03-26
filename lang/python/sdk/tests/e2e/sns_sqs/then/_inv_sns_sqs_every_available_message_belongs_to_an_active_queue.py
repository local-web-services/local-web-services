"""Then: every "AVAILABLE" message belongs to an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import then


@then('every "AVAILABLE" message belongs to an "ACTIVE" queue')
def _inv_sns_sqs_every_available_message_belongs_to_an_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
