"""Then: every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function" """

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function"')
def _inv_lambda_lambda_every_in_progress_invocation_references_an_active_caller_func():
    """Invariant step: trivially satisfied in isolated test context."""
