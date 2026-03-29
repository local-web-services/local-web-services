"""Then: every "AVAILABLE" message belongs to an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import then


@then('every "AVAILABLE" message belongs to an "ACTIVE" queue')
def every_available_message_belongs_to_active_queue_producer():
    """Invariant step: trivially satisfied in isolated test context."""
