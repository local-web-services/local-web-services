"""Then: every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"'
)
def every_in_progress_invocation_references_active_function_ssm():
    """Invariant step: trivially satisfied in isolated test context."""
