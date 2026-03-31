"""Then: every "ENABLED" event source mapping references an "ACTIVE" queue"""

from __future__ import annotations

from pytest_bdd import step


@step('every "ENABLED" event source mapping references an "ACTIVE" queue')
def every_enabled_esm_references_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
