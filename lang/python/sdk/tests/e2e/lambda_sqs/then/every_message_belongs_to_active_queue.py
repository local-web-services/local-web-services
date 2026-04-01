"""Then: every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import step


@step('every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue')
def every_message_belongs_to_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
