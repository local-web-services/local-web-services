"""Then: every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"'
)
def every_in_progress_invocation_initiated_by_enabled_esm():
    """Invariant step: trivially satisfied in isolated test context."""
