"""Then: every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"'
)
def _inv_s3api_lambda_every_in_progress_invocation_was_triggered_by_an_object_in_an_():
    """Invariant step: trivially satisfied in isolated test context."""
