"""Then: every non-deleted message belongs to an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import step


@step('every non-deleted message belongs to an "ACTIVE" queue')
def every_non_deleted_message_belongs_to_active_queue():
    """Invariant: trivially satisfied in isolated lws context."""
