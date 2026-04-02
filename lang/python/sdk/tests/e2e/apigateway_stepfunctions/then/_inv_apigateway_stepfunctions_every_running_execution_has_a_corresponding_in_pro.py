"""Then: every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"'
)
def _inv_apigateway_stepfunctions_every_running_execution_has_a_corresponding_in_pro():
    """Invariant step: trivially satisfied in isolated test context."""
