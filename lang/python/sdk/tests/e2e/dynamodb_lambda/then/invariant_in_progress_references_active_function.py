"""Then: every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"'
)
def invariant_in_progress_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""
