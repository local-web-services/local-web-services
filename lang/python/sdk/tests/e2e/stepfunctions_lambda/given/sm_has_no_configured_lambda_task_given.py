"""Given: the execution's state machine has no Lambda task configured"""

from __future__ import annotations

from pytest_bdd import given


@given("the execution's state machine has no Lambda task configured")
def sm_has_no_configured_lambda_task_given():
    """No-op: covered by state machine creation without Lambda task."""
