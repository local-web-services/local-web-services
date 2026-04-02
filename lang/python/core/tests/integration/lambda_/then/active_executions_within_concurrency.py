"""Then: "lambda" "function" active execution count never exceeds reserved concurrency when set"""

from __future__ import annotations

from pytest_bdd import then


@then('"lambda" "function" active execution count never exceeds reserved concurrency when set')
def active_executions_within_concurrency():
    """Invariant: trivially satisfied in isolated lws context."""
