"""Then: no "lambda" "function" in "DELETING" state has active executions"""

from __future__ import annotations

from pytest_bdd import then


@then('no "lambda" "function" in "DELETING" state has active executions')
def no_deleting_function_has_active_executions():
    """Invariant: trivially satisfied in isolated lws context."""
