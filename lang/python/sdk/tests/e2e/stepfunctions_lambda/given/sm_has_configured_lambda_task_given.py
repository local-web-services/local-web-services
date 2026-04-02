"""Given: the "step functions" "execution"'s state machine has a configured "lambda" task"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "execution"\'s state machine has a configured "lambda" task')
def sm_has_configured_lambda_task_given():
    """No-op: state machine is set up with a Lambda task in the execution setup."""
