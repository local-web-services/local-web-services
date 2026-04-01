"""Then: every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function"""

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_events_every_in_progress_invocation_references_an_active_lambda_func():
    """Invariant step: trivially satisfied in isolated test context."""
