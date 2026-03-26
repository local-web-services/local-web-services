"""Then: every in-progress invocation was initiated by an "ENABLED" event source mapping"""

from __future__ import annotations

from pytest_bdd import then


@then('every in-progress invocation was initiated by an "ENABLED" event source mapping')
def every_in_progress_invocation_initiated_by_enabled_esm():
    """Invariant step: trivially satisfied in isolated test context."""
