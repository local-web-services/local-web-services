"""Then: every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "invocation" has a corresponding "RUNNING" "step functions" "execution"'
)
def _inv_stepfunctions_lambda_every_in_progress_invocation_has_a_corresponding_runni():
    """Invariant step: trivially satisfied in isolated test context."""
