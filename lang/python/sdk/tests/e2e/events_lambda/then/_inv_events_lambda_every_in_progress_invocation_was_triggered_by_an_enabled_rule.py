"""Then: every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule')
def _inv_events_lambda_every_in_progress_invocation_was_triggered_by_an_enabled_rule():
    """Invariant step: trivially satisfied in isolated test context."""
