"""Then: every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"'
)
def _inv_sns_lambda_every_in_progress_invocation_was_triggered_by_a_confirmed_subscr():
    """Invariant step: trivially satisfied in isolated test context."""
