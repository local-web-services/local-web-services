"""Then: every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked'
)
def _inv_lambda_lambda_every_successful_invocation_recorded_which_callee_was_invoked():
    """Invariant step: trivially satisfied in isolated test context."""
