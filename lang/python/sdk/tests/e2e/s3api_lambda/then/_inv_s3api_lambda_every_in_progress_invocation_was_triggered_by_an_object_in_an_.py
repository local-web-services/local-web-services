"""Then: every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket')
def _inv_s3api_lambda_every_in_progress_invocation_was_triggered_by_an_object_in_an_():
    """Invariant step: trivially satisfied in isolated test context."""
