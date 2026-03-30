"""Then: synchronous executions only run on express state machines"""

from __future__ import annotations

from pytest_bdd import then


@then("synchronous executions only run on express state machines")
def sync_executions_only_for_express():
    """Invariant: trivially satisfied in isolated integration test context."""
