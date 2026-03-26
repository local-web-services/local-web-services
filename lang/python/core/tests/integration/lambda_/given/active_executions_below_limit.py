"""Given: the active executions are below the concurrency limit"""

from __future__ import annotations

from pytest_bdd import given


@given("the active executions are below the concurrency limit")
def active_executions_below_limit():
    """No-op: fresh functions have no active executions."""
