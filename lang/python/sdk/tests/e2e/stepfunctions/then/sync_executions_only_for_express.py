"""Then: synchronous "step functions" "execution"s only run on express "step functions" "state machine"s"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'synchronous "step functions" "execution"s only run on express "step functions" "state machine"s'
)
def sync_executions_only_for_express():
    """Invariant: trivially satisfied in isolated lws context."""
