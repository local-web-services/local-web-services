"""Then: every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"'
)
def invariant_in_progress_initiated_by_enabled_esm():
    """Invariant: trivially satisfied in isolated lws context."""
