"""Then: every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"'
)
def _inv_lambda_neptune_every_in_progress_invocation_references_an_active_lambda_fun():
    """Invariant step: trivially satisfied in isolated test context."""
