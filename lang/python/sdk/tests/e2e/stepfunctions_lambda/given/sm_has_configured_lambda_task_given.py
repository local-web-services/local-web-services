"""Given: the execution's state machine has a configured Lambda task"""

from __future__ import annotations

from pytest_bdd import given


@given("the execution's state machine has a configured Lambda task")
def sm_has_configured_lambda_task_given():
    """No-op: state machine is set up with a Lambda task in the execution setup."""
